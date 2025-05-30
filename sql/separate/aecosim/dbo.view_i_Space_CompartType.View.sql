SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_i_Space_CompartType]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID,

dbo.i_Space.number AS [kks],

dbo.i_Space.SafetyCanal AS [SC],
 
CASE 
	WHEN dbo.i_Space.SafetyCanal = 'Common' THEN '5'
	WHEN dbo.i_Space.SafetyCanal = '1,2' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '1,3' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '1,4' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '1,2,3' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '1,2,4' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '1,3,4' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '1,2,3,4' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '2,3' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '2,4' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '2,3,4' THEN '6'
	WHEN dbo.i_Space.SafetyCanal = '3,4' THEN '6'
	ELSE dbo.i_Space.SafetyCanal
END AS 'SafetyCanal',



CASE 
	WHEN dbo.i_Space.AccessArea = 'CA' THEN 'Controlled area'
	WHEN dbo.i_Space.AccessArea = 'SA' THEN 'Supervised area'
	WHEN dbo.i_Space.AccessArea = 'CAA' THEN 'Controlled area'
	ELSE dbo.i_Space.AccessArea
END AS [AcessArea],

CASE 
	WHEN dbo.i_Space.SPF_FireLoadGroup = '<600' THEN '< 600'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '600>' THEN '600 >'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '600-1200' THEN '600 - 1200'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 600>' THEN '600 >'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' <600' THEN '< 600'
	WHEN dbo.i_Space.SPF_FireLoadGroup = ' 600 - 1200' THEN '600 - 1200'
	WHEN dbo.i_Space.SPF_FireLoadGroup = '>1200' THEN '> 1200'
	ELSE dbo.i_Space.SPF_FireLoadGroup
END AS 'FireLoadGroup',

dbo.i_Space.FireCompartmentType AS 'FireCompartmentType'


FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID

GO
