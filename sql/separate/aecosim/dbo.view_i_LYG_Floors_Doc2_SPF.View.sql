SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_LYG_Floors_Doc2_SPF]
AS
SELECT DISTINCT
LEFT(DOC2.Room, 7) AS 'KKS отметки',
'' AS 'Наименование отметки',
SUBSTRING(DOC2.Room,6, 2) AS 'Floor Graded Elevation',
LEFT(DOC2.Room, 5) AS 'Здание',
'Floors' AS 'Класс объекта',
'' AS 'id'

FROM [10.36.69.85].[TAES_7_8].[dbo].[room_charact] AS DOC2
--FROM  [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS DOC2
WHERE Doc2.ROW_STATUS = 'U'







GO
