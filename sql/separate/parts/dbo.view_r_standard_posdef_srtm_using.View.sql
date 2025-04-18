SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_standard_posdef_srtm_using]
AS
SELECT     
	dbo.r_standard_posdef.relID, 
	dbo.posdef.posdefName, 
	dbo.standard.stdName, 
	dbo.standard.stdNumber, 
	dbo.standard.stdNumberAlt, 
	dbo.r_standard_posdef.posdefID, 
	dbo.r_standard_posdef.stdID, 
	dbo.standardtype.stdTypeName, 
	LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) AS stdFullNumber, 
	CASE WHEN dbo.standard.stdNumberAlt IS NULL THEN
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) 
	ELSE
		LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumberAlt, '_', ' '))
	END AS stdFullNumberAlt,
	dbo.standard.stdUsing, 
	COUNT(dbo.sortament.srtmID) AS srtm_cnt, 
	dbo.r_standard_posdef.using
FROM         dbo.sortament 

RIGHT OUTER JOIN dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
LEFT OUTER JOIN dbo.standardtype 
RIGHT OUTER JOIN dbo.standard ON dbo.standardtype.stdTypeID = dbo.standard.stdTypeID ON dbo.r_standard_posdef.stdID = dbo.standard.stdID 
LEFT OUTER JOIN dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID

GROUP BY 
	dbo.r_standard_posdef.relID, 
	dbo.posdef.posdefName, 
	dbo.standard.stdName, 
	dbo.standard.stdNumber, 
	dbo.standard.stdNumberAlt, 
	dbo.r_standard_posdef.posdefID, 
	dbo.r_standard_posdef.stdID, 
	dbo.standardtype.stdTypeName, 
	dbo.standardtype.stdTypeDevision, 
	--LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')), 
	dbo.standard.stdUsing, 
	dbo.sortament.srtmUsing, 
	dbo.r_standard_posdef.using
HAVING      (dbo.sortament.srtmUsing = 1) AND (dbo.r_standard_posdef.using = 1)

GO
