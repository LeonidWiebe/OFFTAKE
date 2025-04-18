SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_standard]
AS
SELECT     
	dbo.standard.stdID, 
	dbo.standardtype.stdTypeID, 
	LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) AS stdFullNumber, 
	CASE WHEN dbo.standard.stdNumberAlt IS NULL THEN
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) 
	ELSE
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumberAlt, '_', ' '))
	END AS stdFullNumberAlt,
	dbo.standard.stdName, 
	dbo.standardtype.stdTypeName, 
	dbo.standard.stdNumber, 
	dbo.standard.stdNumberAlt, 
	dbo.standard.stdUsing, 
	dbo.standardtype.stdTypeDevision, 
	COUNT(dbo.r_standard_posdef.relID) AS spcnt, 
	COUNT(dbo.material.matID) AS matcnt
FROM         dbo.standard 
INNER JOIN dbo.standardtype ON dbo.standard.stdTypeID = dbo.standardtype.stdTypeID 
LEFT OUTER JOIN dbo.material ON dbo.standard.stdID = dbo.material.matID 
LEFT OUTER JOIN dbo.r_standard_posdef ON dbo.standard.stdID = dbo.r_standard_posdef.stdID
GROUP BY 
	dbo.standard.stdID, 
	dbo.standardtype.stdTypeID, 
	dbo.standardtype.stdTypeName, 
	dbo.standardtype.stdTypeDevision, 
	dbo.standard.stdNumber, 
	dbo.standard.stdNumberAlt, 
	dbo.standard.stdName, 
	dbo.standard.stdUsing

GO
