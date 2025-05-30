SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_pendiam]
AS
SELECT DISTINCT 
	dbo.pendiam.flanNumber, 
	dbo.pendiam.diamNumber, 
	dbo.pendiam.flangeThickness AS flangeThick, 
	dbo.pendiam.flangeWidth,
	dbo.r_sortament_property.diameter AS pipeDiam, 
	dbo.r_sortament_property.thickness AS pipeThick, 
	dbo.sortament.srtmID, 
	dbo.view_r_standard_posdef.stdFullNumber
FROM         dbo.view_r_standard_posdef 
INNER JOIN dbo.r_sortament_property 
INNER JOIN dbo.pen 
RIGHT OUTER JOIN dbo.pendiam ON dbo.pen.pendiamID = dbo.pendiam.pendiamID 
INNER JOIN dbo.sortament ON dbo.pendiam.srtmPipeID = dbo.sortament.srtmID ON dbo.r_sortament_property.srtmID = dbo.sortament.srtmID ON dbo.view_r_standard_posdef.relID = dbo.sortament.stdposdefID 
LEFT OUTER JOIN dbo.part ON dbo.pen.partID = dbo.part.partID
WHERE     (dbo.pendiam.depID = 0)

GO
