SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_LYG_Space_Doc2_SPF]
AS
SELECT 

dbo.elements.pwdocID, 

DOC2.Room AS [KKS Помещения],
Doc2.room_name + ' / ' + Doc2.room_name_e AS 'Наименование помещения',
(cast(dbo.getZero(Doc2.area)as nvarchar) + ' m^2') AS 'Площадь, m^2',
(cast(dbo.getZero(Doc2.v)as nvarchar) + ' m^3') AS 'Полный объем помещения m^3',
Doc2.Acсess_area AS 'Зона доступа',
(''''+Doc2.ra_avl) AS 'Зоны радиации',
LEFT(DOC2.Room, 5) AS 'Здание',
LEFT(DOC2.Room, 7) AS 'Отметка',
'Generic' AS 'Класс объекта',
'' AS 'id',

Doc2.If_uchastok 

FROM         dbo.elements 
LEFT JOIN [10.36.69.85].[TAES_7_8].[dbo].[room_charact] AS DOC2 
ON dbo.elements.simID = DOC2.simid
WHERE Doc2.ROW_STATUS = 'U' and doc2.[number_uchastok]=1 -- Заменили по согласованию с Шадринцевым С.В. 2023_03_16
--doc2.If_uchastok='Помещение'
--в room_charact есть не только помещения, но и участки помещений с теми же кодами и simid. 
--По требованиям норм пожарной безопасности, одно помещение может быть разбито на несколько участков, поэтому нужно такое ограничение во вьюхе.



--WHERE elements.pwdocID=1000497
--AND DOC2.Room like '71UBS10%'



--ALTER VIEW [dbo].[view_i_LYG_Space_Doc2_SPF]
--AS
--SELECT 

--DOC2.Room AS [KKS Помещения],
--Doc2.room_name + ' / ' + Doc2.room_name_e AS 'Наименование помещения',
--(cast(dbo.getZero(Doc2.area)as nvarchar) + ' m^2') AS 'Площадь, m^2',
--(cast(dbo.getZero(Doc2.v)as nvarchar) + ' m^3') AS 'Полный объем помещения m^3',
--Doc2.Acсess_area AS 'Зона доступа',
--(''''+Doc2.ra_avl) AS 'Зоны радиации',
--LEFT(DOC2.Room, 5) AS 'Здание',
--LEFT(DOC2.Room, 7) AS 'Отметка',
--'Generic' AS 'Класс объекта',
--'' AS 'id'


--FROM [10.36.69.85].[TAES_7_8].[dbo].[room_charact] AS DOC2



GO
