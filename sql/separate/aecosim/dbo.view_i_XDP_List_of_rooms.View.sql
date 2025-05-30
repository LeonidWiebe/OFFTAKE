SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_XDP_List_of_rooms]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 

-- Закомментировал РешетниковИО 19.10.2021, т.к. в offtake отображалсиь неверные отметки (level)
--CASE
--	when dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 1)) = '±0.000' then '0.000'
--	else dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 1))
--END AS 'level',
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

dbo.i_Space.number AS 'kks', 
dbo.i_Space.label2 AS 'name rus', 
dbo.i_Space.label AS 'name eng', 

DOC2.ra_avl AS 'Radioactive zone',
DOC2.safety_channel AS 'Availability and number of the train',

dbo.getzero2(dbo.getTrueArea2(dbo.elements.simID, 0, 2))  AS 'area', 
dbo.i_RoomAttributes.FinishingGroup AS 'Finishing Group',
DOC2.category_final AS 'Fire load group',
CASE 
	when Doc2.ra_avl = '0' then '-'
	when Doc2.ra_avl = '1' then 'Обслуживаемое'
	when Doc2.ra_avl = '2' then 'Периодически обслуживаемое'
	when Doc2.ra_avl = '3' then 'Периодически обслуживаемое'
	when Doc2.ra_avl = '4' then 'Необслуживаемое'
	ELSE Doc2.ra_avl + ' Некорректные данные'
END AS 'СП-АС-03',

CASE 
	when Doc2.ra_avl = '0' then '-'
	when Doc2.ra_avl = '1' then 'Attended'
	when Doc2.ra_avl = '2' then 'Periodically attended'
	when Doc2.ra_avl = '3' then 'Periodically attendedе'
	when Doc2.ra_avl = '4' then 'Unattended'
	ELSE Doc2.ra_avl + ' Некорректные данные'
END AS 'SP-AS-03',

Doc2.If_uchastok 

--FROM         dbo.elements 
--INNER JOIN dbo.i_Space 
--ON dbo.elements.simID = dbo.i_Space.simID
--INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd 
--ON dbo.elements.pwdocID = dd.id
--left JOIN dbo.i_RoomAttributes 
--ON dbo.elements.simID = dbo.i_RoomAttributes.simID
--inner join [10.36.69.85].[XZS].[dbo].[room_charact] AS DOC2 
--ON DOC2.room=i_Space.number
--WHERE (LEFT(DOC2.Room, 5) not in ('41UJA','41UJG','41UJE','41UKD','41UCB','41UKA','41UQB','41UBS')) AND Doc2.ROW_STATUS = 'U'
-- Переделано Покуль 20.04.2021


FROM         dbo.elements 
INNER JOIN   dbo.i_Space 
ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [10.36.69.85].[XZS].[dbo].[room_charact] AS DOC2 
ON dbo.elements.simID = DOC2.simid
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd
ON dbo.elements.pwdocID = dd.id
left JOIN dbo.i_RoomAttributes 
ON dbo.elements.simID = dbo.i_RoomAttributes.simID

--WHERE doc2.If_uchastok='Помещение'
WHERE doc2.[number_uchastok]=1 -- Заменили по согласованию с Шадринцевым С.В. 2023_03_16
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.



GO
