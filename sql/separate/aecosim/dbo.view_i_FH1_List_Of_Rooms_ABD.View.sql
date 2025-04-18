SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[view_i_FH1_List_Of_Rooms_ABD]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

LEFT(dbo.i_Space.number, 7) AS [KKS отметки],


dbo.i_Space.number AS [KKS],  
dbo.i_Space.label  AS [Name RU], 
dbo.i_Space.label2+' /'  AS [Name EN], 
dbo.i_Space.AccessArea  AS [Access Area], 
--dbo.getFireLoadGroup(dbo.i_Space.SPF_FireLoadGroup)  AS [Fire Load Group], 


dbo.getFireLoadGroup2(dbo.i_Space.SPF_FireLoadGroup) as [Fire Load Group], 

CASE 
	WHEN dbo.i_Space.AccessArea = 'Controlled area' THEN 'CA'
	WHEN dbo.i_Space.AccessArea = 'Supervised area' THEN 'SA'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'CA'
	ELSE dbo.i_Space.AccessArea
END AS '~Access Area',



--dbo.getZero(dbo.getTrueArea(round(dbo.i_Space.actualGross * 1e-10, 1) ,round(dbo.elements.elemarea * 1e-10, 1)))  AS 'Floor Area',
dbo.getZero(dbo.getTrueArea2(dbo.elements.simID, 0, 1)) AS 'Floor Area',


LEFT(dbo.i_Space.number, 5) AS [KKS здания]


FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID

















GO
