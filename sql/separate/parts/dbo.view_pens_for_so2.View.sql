SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_pens_for_so2]
AS
SELECT     TOP (100) PERCENT 'T' + RTRIM(LTRIM(STR(dbo.pendiam.flanNumber))) + '-' + RTRIM(LTRIM(STR(dbo.pendiam.diamNumber))) + '-' AS penName, 
                      dbo.r_sortament_property.diameter AS pipeDiameter, dbo.r_sortament_property.thickness AS pipeThickness
FROM         dbo.pendiam INNER JOIN
                      dbo.sortament ON dbo.pendiam.srtmPipeID = dbo.sortament.srtmID INNER JOIN
                      dbo.r_sortament_property ON dbo.sortament.srtmID = dbo.r_sortament_property.srtmID
WHERE     (dbo.pendiam.depID = 0)
ORDER BY dbo.pendiam.flanNumber, dbo.pendiam.diamNumber
GO
