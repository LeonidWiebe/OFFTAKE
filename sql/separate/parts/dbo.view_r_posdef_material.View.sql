SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_posdef_material]
AS
SELECT     
	dbo.posdef.posdefName, 
	dbo.material.matName, 
	dbo.standardtype.stdTypeName, 
	dbo.standard.stdNumber, 
	dbo.standard.stdNumberAlt, 
	dbo.standard.stdName, 
    dbo.r_posdef_material.relID, 
    dbo.standard.stdID, 
    dbo.posdef.posdefID, 
    dbo.material.matID, 
    LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) AS stdFullNumber, 
	CASE WHEN dbo.standard.stdNumberAlt IS NULL THEN
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) 
	ELSE
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumberAlt, '_', ' '))
	END AS stdFullNumberAlt,
    dbo.material.matSortNumber, 
    dbo.material.matUsing
FROM         dbo.standardtype 

INNER JOIN dbo.standard ON dbo.standardtype.stdTypeID = dbo.standard.stdTypeID 
RIGHT OUTER JOIN dbo.material 
INNER JOIN dbo.r_posdef_material ON dbo.material.matID = dbo.r_posdef_material.matID 
INNER JOIN dbo.posdef ON dbo.r_posdef_material.posdefID = dbo.posdef.posdefID ON dbo.standard.stdID = dbo.material.stdID

WHERE     (dbo.material.matUsing = 1)

GO
