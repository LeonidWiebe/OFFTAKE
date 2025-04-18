SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_PKS2_List_Of_Rooms_SPF]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,
Doc2.Doc2_ID,
Doc2.ID,


--LEFT(dbo.i_Space.number, 7) AS [KKS отметки],

--'' AS '1',
dbo.i_Space.number AS [KKS],  
dbo.i_Space.label + ' / ' + dbo.i_Space.label2 AS [Наименование помещения],
--NULL AS '2',
--'' AS '3',
--'' AS '4',
--'' AS '5',
--'' AS '6',
--'' AS '7',
--dbo.getTrim(dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1) ,round(dbo.elements.elemarea * 1e-10, 1)))  AS 'Area',
--(cast(dbo.getTrim(dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1), round(dbo.elements.elemarea * 1e-10, 1))) as nvarchar) + ' m^2')  AS 'Area', --new
(cast(dbo.getTrim(dbo.getTrueArea2(dbo.elements.simID, 0, 1)) as nvarchar) + ' m^2')  AS 'Area', --new
--(cast(round(dbo.elements.elemVolume * 1e-15, 2,2) as nvarchar) + ' m^3') AS volume,
(cast(dbo.getTrueVolume(dbo.elements.simID, 0, 2) as nvarchar) + ' m^3') AS volume,

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
	ELSE dbo.i_Space.SPF_FireLoadGroup + ' Некорректные данные'
END AS 'Fire load',

CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'Controlled access zone'
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'Uncontrolled access area'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'Controlled access zone'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'Uncontrolled access area'
	WHEN dbo.i_Space.AccessArea = 'Controlled access area' THEN 'Controlled access zone'
	WHEN dbo.i_Space.AccessArea = 'Uncontrolled access area' THEN 'Uncontrolled access area'
	ELSE dbo.i_Space.AccessArea + ' Некорректные данные'
END AS [AcessArea],



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
END AS 'Radiation zone',

CASE 
	WHEN Doc2.ra_avl = '3/Zone 2' THEN 'Ограниченно (кратковременно) / Limited (short-term)'
	WHEN Doc2.ra_avl = '1/Zone 1' THEN 'Постоянно / Continuously'
	WHEN Doc2.ra_avl = '1/Zone 1P' THEN 'Постоянно / Continuously'
	WHEN Doc2.ra_avl = '0/-' THEN 'Постоянно / Continuously'
	WHEN Doc2.ra_avl = '4/Zone 2' THEN 'Нет доступа / No access'
	WHEN Doc2.ra_avl = '4/Zone 3' THEN 'Нет доступа / No access'
	WHEN Doc2.ra_avl = '2/Zone 1' THEN 'Периодически / Periodically'
	
	WHEN Doc2.ra_avl = '3' THEN 'Ограниченно (кратковременно) / Limited (short-term)'
	WHEN Doc2.ra_avl = '1' THEN 'Постоянно / Continuously'
	WHEN Doc2.ra_avl = '0' THEN 'Постоянно / Continuously'
	WHEN Doc2.ra_avl = '4' THEN 'Нет доступа / No access'
	WHEN Doc2.ra_avl = '2' THEN 'Периодически / Periodically'
	ELSE Doc2.ra_avl
END AS 'Personnel access',

'' AS 'Notes',
'Generic' AS 'Type',
--LEFT(dbo.i_Space.number, 7) AS [KKS2 отметки],
--LEFT(dbo.i_Space.number, 5) AS [KKS здания],
--dbo.i_Space.number,
RIGHT(dbo.i_Space.number, 3) as [Номер],
LEFT(dbo.i_Space.number, 7) as [KKS отметки],
LEFT(dbo.i_Space.number, 5) as [KKS здания]
--,dd.project_name AS Proj

FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
--LEFT OUTER JOIN [10.36.69.20].[PKS].[dbo].[Room_charact] AS Doc2 ON i_Space.Doc2_ID = Doc2.Doc2_ID
LEFT OUTER JOIN [10.36.69.20].[PKS].[dbo].[Room_charact] AS Doc2 ON i_Space.simID = Doc2.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
Where dd.project_name = 'Paks-2' AND dd.deleted = 0


--select room_name, room, id, doc2_id from [10.36.69.20].[PKS].[dbo].[Room_charact] where Doc2_ID=7410



GO
