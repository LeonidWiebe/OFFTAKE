SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_sortament_property_3]
AS
SELECT  
dbo.sortament.srtmID, 
dbo.sortament.srtmName, 
dbo.r_standard_posdef.stdID, 
dbo.r_standard_posdef.posdefID, 
dbo.sortament.stdposdefID, 
dbo.sortament.srtmUsing, 
dbo.r_sortament_property.area, 
dbo.r_sortament_property.diameter, 
dbo.r_sortament_property.masslength, 
dbo.r_rein_property.fillet_radius, 
dbo.r_rein_property.fillet_length, 
dbo.r_rein_property.rif_diameter, 
dbo.r_sortament_property.height, 
dbo.r_sortament_property.horthickness, 
dbo.r_sortament_property.massunit, 
dbo.r_sortament_property.massvolume, 
dbo.r_sortament_property.thickness, 
dbo.r_sortament_property.verthickness, 
dbo.r_sortament_property.radius, 
dbo.r_sortament_property.angle, 
dbo.r_sortament_property.width, 
dbo.r_sortament_property.massarea, 
dbo.r_sortament_property.length, 
dbo.r_sortament_property.number,
dbo.r_sortament_property.article, 
dbo.r_sortament_property.dopmass, 
dbo.r_sortament_property.speedmat

FROM         dbo.sortament 

INNER JOIN                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
LEFT OUTER JOIN                 dbo.r_rein_property ON dbo.sortament.srtmID = dbo.r_rein_property.srtmID 
LEFT OUTER JOIN                 dbo.r_sortament_property ON dbo.sortament.srtmID = dbo.r_sortament_property.srtmID

GO
