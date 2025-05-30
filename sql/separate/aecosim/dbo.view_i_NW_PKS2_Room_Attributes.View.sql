SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_NW_PKS2_Room_Attributes]
AS
SELECT   
	--dbo.i_Space.[Doc2_ID] as Doc2ID,   
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
--dbo.i_Space.number AS 'Oder',	
dbo.i_Space.number AS '~Name',
dbo.i_Space.label + ' / ' + dbo.i_Space.label2 AS [~Description],
dbo.i_Space.NumFireComp2 AS '~KKS of Fire Compartment',
--dbo.getTrim(dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1) ,round(dbo.elements.elemarea * 1e-10, 1)))  AS '~Area',
dbo.getTrim(dbo.getTrueArea2(dbo.elements.simID, 0, 1))  AS '~Area',
--round(dbo.elements.elemVolume * 1e-15, 1,2) AS '~Volume', 


dbo.getTrueVolume(dbo.elements.simID, 0, 1) AS [~Volume], 

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.i_Space.AccessArea AS '~Access Area',

'Из Doc2 -->' AS 'из Doc2',
CASE 
	WHEN dbo.i_Space.SPF_FireLoadGroup = '<500' THEN '<  500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '>1500' THEN '> 1500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '500 - 1500' THEN '500 - 1500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 500>' THEN '> 1500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' <500' THEN '<  500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 500 - 1500' THEN '500 - 1500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '>1500' THEN '> 1500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '< 500' THEN '<  500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '> 1500' THEN '> 1500 MJ / m2'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '500-1500' THEN '500 - 1500 MJ / m2'
	ELSE dbo.i_Space.SPF_FireLoadGroup + ' Не корректные данные'
END AS '~Fire load',


CASE 
	WHEN Doc2.ra_avl = '3/Zone 2' THEN '3'
	WHEN Doc2.ra_avl = '1/Zone 1' THEN '1'
	WHEN Doc2.ra_avl = '1/Zone 1P' THEN '1'
	WHEN Doc2.ra_avl = '0/-' THEN '0'
	WHEN Doc2.ra_avl = '4/Zone 2' THEN '4'
	WHEN Doc2.ra_avl = '2/Zone 1' THEN '2'
	WHEN Doc2.ra_avl = '4/Zone 3' THEN '4'
	WHEN Doc2.ra_avl = '3' THEN '3'
	WHEN Doc2.ra_avl = '1' THEN '1'
	WHEN Doc2.ra_avl = '0' THEN '0'
	WHEN Doc2.ra_avl = '4' THEN '4'
	WHEN Doc2.ra_avl = '2' THEN '2'
	ELSE Doc2.ra_avl + ' Некорректные данные'
END AS '~Radiation Zone',

--dbo.i_Space.SafetyCanal AS '~Safety Canal',
doc.o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN [10.36.69.20].[PKS].[dbo].[room_charact] AS Doc2 ON i_Space.number = Doc2.room



GO
