SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_XDP_Floors_Doc2_SPF]
AS
SELECT DISTINCT
LEFT(DOC2.Room, 7) AS 'KKS отметки',
'' AS 'Наименование отметки',
SUBSTRING(DOC2.Room,6, 2) AS 'Floor Graded Elevation',
LEFT(DOC2.Room, 5) AS 'Здание',
'Floors' AS 'Класс объекта',
'' AS 'id',

DOC2.If_uchastok

FROM [10.36.69.85].[XZS].[dbo].[room_charact] AS DOC2
WHERE Doc2.ROW_STATUS = 'U' and DOC2.If_uchastok='Помещение'
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.









GO
