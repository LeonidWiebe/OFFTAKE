SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_FH1_Door_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.i_DoorProperties.KKS AS '~Name',

CASE 
	WHEN dbo.i_DoorProperties.FireResistance IS NULL THEN 'Нет данных'
	WHEN dbo.i_DoorProperties.FireResistance = 'не требуется' THEN 'N/A'
	ELSE dbo.i_DoorProperties.FireResistance
END AS '~Fire resistance',

dbo.i_DoorProperties.Type AS '~Door type',
round((dbo.i_Dimensions.width * 1e-2)-100, 0,2) AS '~Aperture width (in clear)', 
 round((dbo.i_Dimensions.height * 1e-2)-100, 0,2) AS '~Aperture height (in clear)',
dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS '~Installation level', --Леонид обновил Range, и теперь нужно перезапускать файлы в оффтэйк, если отметка приходит неверной.
dbo.i_DoorProperties.KKS_Room1 AS '~KKS code of room 1',
dbo.i_DoorProperties.KKS_Room2 AS '~KKS code of room 2',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename,

(case --пожар
	when dbo.i_DoorProperties.FireResistance='N/A' then ''
	else 'F'
end) + 
--substring((CASE --внутр/наружн
	--WHEN DP.KKS_Room1 = '' or DP.KKS_Room2 = '' Then ''
	--WHEN (DP.KKS_Room1 = 'NPP site' or DP.KKS_Room2 = 'NPP site') Then 'External/Наружная'
	--else 'Internal/Внутреняя'
--END),1,1) +
substring((CASE --внутр/наружн
	WHEN (dbo.i_DoorProperties.KKS_Room1 = 'NPP site' or dbo.i_DoorProperties.KKS_Room2 = 'NPP site') Then 'External/Наружная'
	else 'Internal/Внутреняя'
END),1,1) +
substring(dbo.elements.catitem,1,1) + --дверь/ворота
(case  --ширина
	when dbo.elements.catitem='FH1G26p' then '13+10' --исключение для неравнопольных ворот
	when substring(dbo.elements.catitem,4,1) = 'G' and dbo.elements.catitem !='FH1G26p' then substring((cast(round ((dbo.i_Dimensions.width * 1e-2)/2, 2, 2) as varchar)),1,2)+'+'+substring((cast(round ((dbo.i_Dimensions.width * 1e-2)/2, 2, 2) as varchar)),1,2) --равнопольные ворота
	when round(dbo.i_Dimensions.width * 1e-2, 2, 2)<1000 then substring((cast(round (dbo.i_Dimensions.width * 1e-2, 2, 2) as varchar)),1,1) --однопольные двери меньше 1000
	when round(dbo.i_Dimensions.width * 1e-2, 2, 2)>=1000 and round(dbo.i_Dimensions.width * 1e-2, 2, 2)<1200 then substring((cast(round (dbo.i_Dimensions.width * 1e-2, 2, 2) as varchar)),1,2) --однопольные двери больше 1000
	when round(dbo.i_Dimensions.width * 1e-2, 2, 2)=1200 then '9+3' --неравнопольные двери 1200
	when round(dbo.i_Dimensions.width * 1e-2, 2, 2)=1300 then '9+4' --неравнопольные двери 1300
	when substring(dbo.elements.catitem,4,1)!='G' and round(dbo.i_Dimensions.width * 1e-2, 2, 2)>1300 and round(dbo.i_Dimensions.width * 1e-2, 2, 2)<2000 then substring((cast(round((dbo.i_Dimensions.width * 1e-2)/2, 2, 2) as varchar)),1,1)+'+'+substring((cast(round((dbo.i_Dimensions.width * 1e-2)/2, 2, 2) as varchar)),1,1) --равнопольные двери меньше 2000
	when substring(dbo.elements.catitem,4,1)!='G' and round(dbo.i_Dimensions.width * 1e-2, 2, 2)>=2000 then substring((cast(round((dbo.i_Dimensions.width * 1e-2)/2, 2, 2) as varchar)),1,2)+'+'+substring((cast(round((dbo.i_Dimensions.width * 1e-2)/2, 2, 2) as varchar)),1,2) --равнопольные двери больше 2000
	else 'ойойой'
end)+'x'+
substring(cast(round (dbo.i_Dimensions.height * 1e-2, 2, 2) as varchar),1,2) --высота
	as 'DoorMark'


FROM         dbo.elements 
INNER JOIN   dbo.i_DoorProperties ON dbo.elements.simID = dbo.i_DoorProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID
 



















GO
