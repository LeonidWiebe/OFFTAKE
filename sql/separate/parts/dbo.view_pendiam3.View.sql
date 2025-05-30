SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_pendiam3]
AS
SELECT DISTINCT 
                      dbo.pendiam.flanNumber, dbo.pendiam.diamNumber, dbo.pendiam.flangeThickness AS flangeThick, dbo.pendiam.flangeWidth, dbo.pendiam.flangeQty, 
                      dbo.r_sortament_property.diameter AS pipeDiam, dbo.r_sortament_property.thickness AS pipeThick, dbo.pendiam.depID, dbo.pendiam.prjID, dbo.sortament.srtmID, 
                      dbo.standard.stdNumber, dbo.standard.stdID
FROM         dbo.pendiam INNER JOIN
                      dbo.r_sortament_property ON dbo.pendiam.srtmPipeID = dbo.r_sortament_property.srtmID INNER JOIN
                      dbo.sortament ON dbo.sortament.srtmID = dbo.r_sortament_property.srtmID INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.standard ON dbo.r_standard_posdef.stdID = dbo.standard.stdID
GO
