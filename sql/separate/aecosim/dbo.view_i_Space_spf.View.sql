SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_Space_spf]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,


dbo.i_Space.number AS [kks],  
dbo.i_Space.label + ' / ' + dbo.i_Space.label2 AS [name], 
-- dbo.i_Space.actualGross * 1e-10 AS area,
--(cast(dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1, 1) ,round(dbo.elements.elemarea * 1e-10, 1, 1)) as nvarchar) + ' m^2') AS area,
(cast(dbo.getTrueArea2(dbo.elements.simID, 0, 1) as nvarchar) + ' m^2') AS area,
--round(dbo.elements.elemarea * 1e-10, 1, 1) AS area,
--'m^2' AS'Ед.измер. S',
-- dbo.elements.elemVolume * 1e-15 AS volume, 
--round(dbo.elements.elemVolume * 1e-15, 2,2) + ' m^3' AS volume, 
--(cast(round(dbo.elements.elemVolume * 1e-15, 2,2) as nvarchar) + ' m^3') AS volume,
(cast(dbo.getTrueVolume(dbo.elements.simID, 0, 2) as nvarchar) + ' m^3') AS volume,
--'m^3' AS 'Ед.измер. V',
--(cast(1 as nvarchar) + ' m2') as test,


CASE 
	WHEN dbo.i_Space.AccessArea = 'CA' THEN 'Controlled area'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'Supervised area'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'Controlled area'
	ELSE dbo.i_Space.AccessArea
END AS [AcessArea],

CASE 
	WHEN Doc2.ra_avl ='0/-' THEN '0 / -'
	WHEN Doc2.ra_avl ='1/Zone 1' THEN '1 / Zone 1'
	WHEN Doc2.ra_avl ='2/Zone 1' THEN '2 / Zone 1'
	WHEN Doc2.ra_avl ='3/Zone 2' THEN '3 / Zone 2'
	WHEN Doc2.ra_avl ='4/Zone 2' THEN '4 / Zone 2'
	WHEN Doc2.ra_avl ='5/Zone 3' THEN '5 / Zone 3'
	ELSE Doc2.ra_avl
END AS 'Radiation zone',


CASE 
	WHEN Doc2.ra_avi_ppr ='0/-' THEN '0 / -'
	WHEN Doc2.ra_avi_ppr ='1/Zone 1' THEN '1 / Zone 1'
	WHEN Doc2.ra_avi_ppr ='2/Zone 1' THEN '2 / Zone 1'
	WHEN Doc2.ra_avi_ppr ='3/Zone 2' THEN '3 / Zone 2'
	WHEN Doc2.ra_avi_ppr ='4/Zone 2' THEN '4 / Zone 2'
	WHEN Doc2.ra_avi_ppr ='5/Zone 3' THEN '5 / Zone 3'
	ELSE Doc2.ra_avi_ppr
END AS 'Radiation zone/PM',



Doc2.Internal_flooding_zone AS 'Internal flooding zone',

'' AS 'Notes',
'Generic' AS 'Классификатор помещения',

LEFT(dbo.i_Space.number, 7) AS [KKS отметки],
LEFT(dbo.i_Space.number, 5) AS [KKS здания]


--FROM         dbo.elements 
--INNER JOIN   dbo.i_Space 
--ON dbo.elements.simID = dbo.i_Space.simID
--LEFT JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS Doc2 
--ON i_Space.number = Doc2.room
--INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd 
--ON dbo.elements.pwdocID = dd.id
--Where dd.project_name = 'Hanhikivi' AND dd.deleted = 0


FROM         dbo.elements 
INNER JOIN   dbo.i_Space 
ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS Doc2 
ON dbo.elements.simID = Doc2.simid
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd 
ON dbo.elements.pwdocID = dd.id
Where dd.project_name = 'Hanhikivi' AND dd.deleted = 0


-- and dbo.elements.simID = '3302472'
-- and number like '10USER96%' -- пример запроса



GO
