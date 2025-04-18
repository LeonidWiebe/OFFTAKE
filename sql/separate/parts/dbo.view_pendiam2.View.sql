SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_pendiam2]
AS
SELECT DISTINCT 
dbo.pendiam.flanNumber, 
dbo.pendiam.diamNumber, 
dbo.pendiam.flangeThickness AS flangeThick, 
dbo.pendiam.flangeWidth,
dbo.r_sortament_property.diameter AS pipeDiam, 
dbo.r_sortament_property.thickness AS pipeThick, 
dbo.pendiam.depID,
dbo.pendiam.prjID,
CASE
	WHEN pendiam.flanNumber=5  Then 'C'
	ELSE CAST(flanNumber AS varchar)
END AS penCode

FROM         dbo.r_sortament_property 
INNER JOIN dbo.pendiam ON dbo.pendiam.srtmPipeID = dbo.r_sortament_property.srtmID
INNER JOIN dbo.sortament ON dbo.sortament.srtmID = dbo.r_sortament_property.srtmID



GO
