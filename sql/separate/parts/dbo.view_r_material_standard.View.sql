SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_material_standard]
AS
SELECT   TOP (100) PERCENT
	dbo.material.matID, 
	dbo.standard.stdID, 
	dbo.standardtype.stdTypeID, 
	dbo.material.matName, 
	dbo.standardtype.stdTypeName, 
	dbo.standard.stdNumber, 
	dbo.standard.stdNumberAlt, 
	dbo.standard.stdName, 
    LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) AS stdFullNumber, 
	CASE WHEN dbo.standard.stdNumberAlt IS NULL THEN
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) 
	ELSE
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumberAlt, '_', ' '))
	END AS stdFullNumberAlt,
    dbo.material.matUsing, 
    dbo.armclass.armclassName, 
    dbo.material.matSortNumber, 
    dbo.armclass.oldName, 
    dbo.material.armclassID, 
    dbo.material.matMassCorrect
FROM         dbo.armclass 

RIGHT OUTER JOIN dbo.material ON dbo.armclass.armclassID = dbo.material.armclassID 
LEFT OUTER JOIN dbo.standardtype 
INNER JOIN dbo.standard ON dbo.standardtype.stdTypeID = dbo.standard.stdTypeID ON dbo.material.stdID = dbo.standard.stdID

ORDER BY dbo.material.matSortNumber

GO
