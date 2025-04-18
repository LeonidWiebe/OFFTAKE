SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[view_i_FH1_Door_Attributes_list]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dd.[o_docguid] as docguid,
dbo.elements.elemOldID, 

dbo.elements.catitem as 'type',
DP.KKS_Room1 as 'KKS Room 1',
DP.KKS_Room2 as 'KKS Room 2',
(case --пожар
	when DP.FireResistance='N/A' then ''
	else 'F'
end) + 
--substring((CASE --внутр/наружн
	--WHEN DP.KKS_Room1 = '' or DP.KKS_Room2 = '' Then ''
	--WHEN (DP.KKS_Room1 = 'NPP site' or DP.KKS_Room2 = 'NPP site') Then 'External/Наружная'
	--else 'Internal/Внутреняя'
--END),1,1) +
substring((CASE --внутр/наружн
	WHEN (DP.KKS_Room1 = 'NPP site' or DP.KKS_Room2 = 'NPP site') Then 'External/Наружная'
	else 'Internal/Внутреняя'
END),1,1) +
substring(dbo.elements.catitem,1,1) + --дверь/ворота
(case  --ширина
	when dbo.elements.catitem='FH1G26p' then '13+10' --исключение для неравнопольных ворот
	when substring(dbo.elements.catitem,4,1) = 'G' and dbo.elements.catitem !='FH1G26p' then substring((cast(round ((DM.width * 1e-2)/2, 2, 2) as varchar)),1,2)+'+'+substring((cast(round ((DM.width * 1e-2)/2, 2, 2) as varchar)),1,2) --равнопольные ворота
	when round(DM.width * 1e-2, 2, 2)<1000 then substring((cast(round (DM.width * 1e-2, 2, 2) as varchar)),1,1) --однопольные двери меньше 1000
	when round(DM.width * 1e-2, 2, 2)>=1000 and round(DM.width * 1e-2, 2, 2)<1200 then substring((cast(round (DM.width * 1e-2, 2, 2) as varchar)),1,2) --однопольные двери больше 1000
	when round(DM.width * 1e-2, 2, 2)=1200 then '9+3' --неравнопольные двери 1200
	when round(DM.width * 1e-2, 2, 2)=1300 then '9+4' --неравнопольные двери 1300
	when substring(dbo.elements.catitem,4,1)!='G' and round(DM.width * 1e-2, 2, 2)>1300 and round(DM.width * 1e-2, 2, 2)<2000 then substring((cast(round((DM.width * 1e-2)/2, 2, 2) as varchar)),1,1)+'+'+substring((cast(round((DM.width * 1e-2)/2, 2, 2) as varchar)),1,1) --равнопольные двери меньше 2000
	when substring(dbo.elements.catitem,4,1)!='G' and round(DM.width * 1e-2, 2, 2)>=2000 then substring((cast(round((DM.width * 1e-2)/2, 2, 2) as varchar)),1,2)+'+'+substring((cast(round((DM.width * 1e-2)/2, 2, 2) as varchar)),1,2) --равнопольные двери больше 2000
	else 'ойойой'
end)+'x'+
substring(cast(round (DM.height * 1e-2, 2, 2) as varchar),1,2) --высота
	as 'DoorMark',




DP.KKS AS 'KKS / MCS No.',

DP.Type AS 'Name of the equipment, item and material',
'-' AS 'Type, grade, model, code (drive model)',
cast(round (DM.width * 1e-2, 2, 2) as varchar) as 'width',
cast(round (DM.height * 1e-2, 2, 2) as varchar) as 'height',
(CASE
	WHEN round (DM.width * 1e-2, 2, 2) >= 1200 Then 'Double (D)/Двупольное'
	else 'Single (S)/Однопольное'
END) as 'Door leaf type/ Тип дверного полотна', 
DP.FireResistance as 'Fire resistance/Предел огнестойкости',
(CASE
	WHEN DP.SmokeTightness != '' Then DP.SmokeTightness
		else ' '
END) as 'Smoke-tightness/Дымогазонепроницаемость', 
(CASE
	WHEN DP.KKS_Room1 = '' or DP.KKS_Room2 = '' Then ''
	WHEN (DP.KKS_Room1 = 'NPP site' or DP.KKS_Room2 = 'NPP site') Then 'External/Наружная'
	else 'Internal/Внутреняя'
END) AS 'Door type (by environment)/Тип двери (по окружающей среде)',

'-' AS 'Code of Design Requirements',
'-' AS 'Normative basis and equipment classification',
DP.Material AS 'Material',
'pcs / шт' AS 'U/M',
'1' AS 'Quantity',
DP.Mass_of_unit AS 'Mass of unit',
(LEFT(DP.KKS, 5)) as 'Building',
DP.KKS_Room1 AS 'Room',
'' AS 'Note'
--,dd.deleted
--,dd.project_name


FROM         dbo.elements 


INNER JOIN dbo.i_DoorProperties AS DP ON dbo.elements.simID = DP.simID 
INNER JOIN dbo.i_Dimensions AS DM ON dbo.elements.simID = DM.simID


INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
--INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid























GO
