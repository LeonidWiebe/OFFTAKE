SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_pen]
AS
SELECT     'T' + RTRIM(LTRIM(STR(dbo.pendiam.flanNumber))) + '-' + RTRIM(LTRIM(STR(dbo.pendiam.diamNumber))) 
                      + '-' + RTRIM(LTRIM(STR(dbo.pen.wallThickness / 10))) AS penName, dbo.pendiam.flanNumber, dbo.pendiam.diamNumber, dbo.pen.wallThickness, 
                      dbo.pendiam.flangeWidth, dbo.pendiam.flangeThickness, RTRIM(LTRIM(STR(dbo.pendiam.flanNumber)) 
                      + RTRIM(LTRIM(STR(dbo.pendiam.diamNumber))) + RTRIM(LTRIM(STR(dbo.pen.wallThickness)))) AS mslink, 
                      dbo.r_sortament_property.diameter AS pipeDiameter, dbo.r_sortament_property.thickness AS pipeThickness
FROM         dbo.pen RIGHT OUTER JOIN
                      dbo.pendiam ON dbo.pen.pendiamID = dbo.pendiam.pendiamID INNER JOIN
                      dbo.sortament ON dbo.pendiam.srtmPipeID = dbo.sortament.srtmID INNER JOIN
                      dbo.r_sortament_property ON dbo.sortament.srtmID = dbo.r_sortament_property.srtmID LEFT OUTER JOIN
                      dbo.part ON dbo.pen.partID = dbo.part.partID
WHERE     (dbo.pendiam.depID = 0)
GO
