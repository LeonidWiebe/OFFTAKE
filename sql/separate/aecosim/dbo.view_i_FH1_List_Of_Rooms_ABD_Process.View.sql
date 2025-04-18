SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_FH1_List_Of_Rooms_ABD_Process]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

LEFT(dbo.i_Space.number, 7) AS [KKS отметки],


dbo.i_Space.number AS [KKS],  
dbo.i_Space.label  AS [Name RU], 
dbo.i_Space.label2+' /'  AS [Name EN], 


--CASE 
--	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'CA'
--	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'SA'
--	ELSE dbo.i_Space.AccessArea
--END AS '~Access Area',

CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'Controlled area /'
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'Supervised area /'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'Supervised area'
	ELSE dbo.i_Space.AccessArea
END AS '~Access Area',

CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'Зона контролируемого доступа'
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'Зона свободного доступа'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'Зона свободного доступа'
	ELSE dbo.i_Space.AccessArea
END AS '~Access Area RU',


LEFT(dbo.i_Space.number, 5) AS [KKS здания]


FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID




















GO
