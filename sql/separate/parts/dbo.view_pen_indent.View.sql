SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_pen_indent]
AS
SELECT     'T' + RTRIM(LTRIM(STR(dbo.pendiam.flanNumber))) + '-' + RTRIM(LTRIM(STR(dbo.pendiam.diamNumber))) 
                      + '-' + RTRIM(LTRIM(STR(dbo.pen.wallThickness / 10))) AS penName, dbo.pendiam.flanNumber, dbo.pendiam.diamNumber, dbo.pen.wallThickness, 
                      dbo.pendiam.flangeWidth, dbo.pendiam.flangeThickness, RTRIM(LTRIM(STR(dbo.pendiam.flanNumber)) 
                      + RTRIM(LTRIM(STR(dbo.pendiam.diamNumber))) + RTRIM(LTRIM(STR(dbo.pen.wallThickness)))) AS mslink, 
                      RTRIM(LTRIM(STR(dbo.ms_pen_indent.indentWidth))) + 'x' + RTRIM(LTRIM(STR(dbo.ms_pen_indent.indentHeight))) 
                      + 'x' + RTRIM(LTRIM(STR(dbo.ms_pen_indent.indentDepth))) AS penIndent, dbo.ms_pen_indent.indentWidth, dbo.ms_pen_indent.indentHeight, 
                      dbo.ms_pen_indent.indentDepth, dbo.r_sortament_property.diameter AS pipeDiameter, dbo.r_sortament_property.thickness AS pipeThickness
FROM         dbo.r_sortament_property INNER JOIN
                      dbo.pen RIGHT OUTER JOIN
                      dbo.pendiam ON dbo.pen.pendiamID = dbo.pendiam.pendiamID INNER JOIN
                      dbo.sortament ON dbo.pendiam.srtmPipeID = dbo.sortament.srtmID INNER JOIN
                      dbo.ms_pen_indent ON dbo.pen.pendiamID = dbo.ms_pen_indent.pendiamID ON 
                      dbo.r_sortament_property.srtmID = dbo.sortament.srtmID LEFT OUTER JOIN
                      dbo.part ON dbo.pen.partID = dbo.part.partID
WHERE     (dbo.pendiam.depID = 0)
GO
