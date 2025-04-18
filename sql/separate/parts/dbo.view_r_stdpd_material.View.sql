SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_stdpd_material]
AS
SELECT     
	dbo.material.matName, 
	dbo.standardtype.stdTypeName, 
	dbo.standard.stdNumber, 
	dbo.standard.stdNumberAlt, 
	dbo.standard.stdName, 
	dbo.standard.stdID, 
	LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) AS stdFullNumber, 
	CASE WHEN dbo.standard.stdNumberAlt IS NULL THEN
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) 
	ELSE
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumberAlt, '_', ' '))
	END AS stdFullNumberAlt,
	dbo.material.matSortNumber, 
	dbo.r_stdpd_material.stdpdID, 
	dbo.r_stdpd_material.matID
FROM         dbo.standardtype 

INNER JOIN dbo.standard ON dbo.standardtype.stdTypeID = dbo.standard.stdTypeID 
RIGHT OUTER JOIN dbo.material 
INNER JOIN dbo.r_stdpd_material ON dbo.material.matID = dbo.r_stdpd_material.matID ON dbo.standard.stdID = dbo.material.stdID

WHERE     (dbo.material.matUsing = 1)

GO
