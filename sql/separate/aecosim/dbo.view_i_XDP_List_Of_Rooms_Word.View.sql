SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_XDP_List_Of_Rooms_Word]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 

LEFT(dbo.i_Space.number, 7) AS [KKS отметки],

-- Закомментировал РешетниковИО 19.10.2021, т.к. в offtake отображалсиь неверные отметки (level)
--round(dbo.elements.pMinZ* 1e-3, 1) AS 'level_numb',
--CASE
--	when dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 1)) = '±0.000' then '0.000'
--	else dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 1))
--END AS 'level',
round(CAST( dbo.elements.pMinZ AS DECIMAL )/1000, 2, 1) AS 'level_numb',
CASE
	when dbo.getZeroPlus( round(CAST( dbo.elements.pMinZ AS DECIMAL )/1000, 2, 1) ) = '±0.000' then '0.000'
	else dbo.getZeroPlus( round(CAST( dbo.elements.pMinZ AS DECIMAL )/1000, 2, 1) )
END AS 'level',


dbo.i_RoomAttributes.AccessArea AS 'access_area',
CASE 
	when dbo.i_RoomAttributes.AccessArea = 'Controlled area' then 'Зона контролируемого доступа'
	when dbo.i_RoomAttributes.AccessArea = 'Supervised area' then 'Зона свободного доступа'
	ELSE dbo.i_RoomAttributes.AccessArea 
END AS 'Зона доступа',

dbo.i_Space.number AS 'KKS code', 
dbo.i_Space.label2 AS 'name of room rus', 
dbo.i_Space.label AS 'name of room eng', 

dbo.getzero2(dbo.getTrueArea2(dbo.elements.simID, 0, 1))  AS 'Room area', 
dbo.i_RoomAttributes.FinishingGroup AS 'Finishing Group',

DOC2.category_final AS 'Category as per NPB 105-2003',

DOC2.SP_AS_03 AS 'Requirements for production rooms as per СП-АС-03',

Doc2.If_uchastok 

--,dd.project_name

FROM         dbo.elements 
INNER JOIN   dbo.i_Space 
ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [10.36.69.85].[XZS].[dbo].[room_charact] AS DOC2 
ON dbo.elements.simID = DOC2.simid
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd
ON dbo.elements.pwdocID = dd.id
left JOIN dbo.i_RoomAttributes 
ON dbo.elements.simID = dbo.i_RoomAttributes.simID

WHERE doc2.If_uchastok='Помещение'
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.




GO
