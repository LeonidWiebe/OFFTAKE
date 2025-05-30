SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_sortament_property__tmp]
AS
SELECT     TOP (100) PERCENT dbo.view_posdef.posdefName, dbo.sortament.srtmName, dbo.view_standard.stdFullNumber, dbo.view_standard.stdName, 
                      dbo.r_sortament_property.area, dbo.r_sortament_property.diameter, dbo.r_sortament_property.height, dbo.r_sortament_property.horthickness, 
                      dbo.r_sortament_property.masslength, dbo.r_sortament_property.massunit, dbo.r_sortament_property.massvolume, dbo.r_sortament_property.thickness, 
                      dbo.r_sortament_property.verthickness, dbo.r_sortament_property.width, dbo.r_sortament_property.radius, dbo.r_sortament_property.angle, 
                      dbo.r_sortament_property.massarea, dbo.r_sortament_property.length, dbo.r_rein_property.fillet_radius, dbo.r_rein_property.fillet_length, 
                      dbo.r_rein_property.rif_diameter
FROM         dbo.sortament INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.view_posdef ON dbo.r_standard_posdef.posdefID = dbo.view_posdef.posdefID INNER JOIN
                      dbo.view_standard ON dbo.r_standard_posdef.stdID = dbo.view_standard.stdID LEFT OUTER JOIN
                      dbo.r_rein_property ON dbo.sortament.srtmID = dbo.r_rein_property.srtmID LEFT OUTER JOIN
                      dbo.r_sortament_property ON dbo.sortament.srtmID = dbo.r_sortament_property.srtmID
GO
