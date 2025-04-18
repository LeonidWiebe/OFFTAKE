SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_XDP_Space_Doc2]
AS
SELECT 

SUBSTRING(DOC2.Room,6, 2) AS [KKS отметки],
Case
 WHEN LEFT(DOC2.Room, 5) = '81UJB' THEN '81UJA'
 WHEN LEFT(DOC2.Room, 5) = '71UJB' THEN '71UJA'
 Else LEFT(DOC2.Room, 5)
END AS [KKS здания], 
Case 
	WHEN SUBSTRING(DOC2.Room,3, 3) = 'UKC' OR SUBSTRING(DOC2.Room,3, 3) = 'UKT' Then DOC2.Room
	ELSE SUBSTRING(DOC2.Room,3, 11) 
END AS 'Room KKS Code',
Doc2.room_name + ' / ' + Doc2.room_name_e AS 'Room name',
Doc2.area AS 'Room area',
Doc2.finishing_group_type AS 'Finishing group, type',
Doc2.fire_dng_class_1 AS 'The fire hazard category previously accepted',
Doc2.SP_AS_03 AS 'Requirements for production rooms as per  СП-АС-03',

Case
	When Doc2.SP_AS_03 is null Then 'Заполни Requirements for production'
	When Doc2.SP_AS_03 = '-' Then 'Зона свободного доступа / Uncontrolled access area'
	Else  'Зона контролируемого доступа / Controlled access area'
End AS 'Access area',

Doc2.If_uchastok

FROM [10.36.69.85].[XZS].[dbo].[room_charact] AS DOC2
WHERE (LEFT(DOC2.Room, 5) not in ('81UJA','81UJG','81UJE','81UKD','81UCB','81UKA','81UQB','81UBS')) AND Doc2.ROW_STATUS = 'U' and doc2.If_uchastok='Помещение'
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.


GO
