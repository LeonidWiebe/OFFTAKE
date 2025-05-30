SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_LYG_Space_Doc2]
AS
SELECT 

Case 
    When DOC2.Room is null Then '-'
	When DOC2.Room = 'N1UGF' Then '00'
    When DOC2.Room = 'N2UGF' Then '00'
    ELSE SUBSTRING(DOC2.Room,6, 2)
	END AS [KKS отметки],



Case
 WHEN LEFT(DOC2.Room, 5) = '81UJB' THEN '81UJA'
 WHEN LEFT(DOC2.Room, 5) = '71UJB' THEN '71UJA'
 Else LEFT(DOC2.Room, 5)
END AS [KKS здания], 
Case 
    When DOC2.Room is null Then '-'
	When DOC2.Room = 'N1UGF' Then '00'
    When DOC2.Room = 'N2UGF' Then '00'
	WHEN SUBSTRING(DOC2.Room,3, 3) = 'UKC' OR SUBSTRING(DOC2.Room,3, 3) = 'UKT' Then DOC2.Room
	ELSE SUBSTRING(DOC2.Room,3, 11) 
END AS 'Room KKS Code',
Case
	When Doc2.room_name is null Then '-'
	When Doc2.room_name_e is null Then '-'
	Else Doc2.room_name + ' / ' + Doc2.room_name_e 
End AS 'Room name',

Doc2.area AS 'Room area',
Doc2.finishing_group_type AS 'Finishing group, type',
Doc2.fire_dng_class_1 AS 'The fire hazard category previously accepted',
Case
	When Doc2.category_final is null Then '-'
	Else  Doc2.category_final
End AS 'category_final',
Doc2.SP_AS_03 AS 'Requirements for production rooms as per  СП-АС-03',
Doc2.ra_avl AS 'radiation_zone',

Case
	When Doc2.SP_AS_03 is null Then 'Заполни Requirements for production'
	When Doc2.SP_AS_03 = '-' Then 'Зона свободного доступа / Uncontrolled access area'
	Else  'Зона контролируемого доступа / Controlled access area'
End AS 'Access area',

Doc2.If_uchastok 

--FROM [10.36.69.85].[TAES_7_8].[dbo].[room_charact] AS DOC2
--WHERE (LEFT(DOC2.Room, 5) not in ('81UJA','81UJG','81UJE','81UKD','81UCB','81UKA','81UQB','81UBS','')) AND DOC2.Room !='ё' AND Doc2.ROW_STATUS = 'U'
-- Переделано Покуль 15.04.2021

FROM         dbo.elements 
INNER JOIN   dbo.i_Space 
ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [10.36.69.85].[TAES_7_8].[dbo].[room_charact] AS DOC2 
ON dbo.elements.simID = DOC2.simid
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd
ON dbo.elements.pwdocID = dd.id
--Where dd.project_name = 'Hanhikivi' AND dd.deleted = 0

--WHERE doc2.If_uchastok='Помещение'
WHERE doc2.[number_uchastok]=1 -- Заменили по согласованию с Шадринцевым С.В. 2023_03_16
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.




GO
