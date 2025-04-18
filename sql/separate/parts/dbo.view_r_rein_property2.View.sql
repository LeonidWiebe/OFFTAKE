SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_rein_property2]
AS
SELECT     dbo.posdef.posdefName, dbo.view_standard.stdFullNumber, dbo.sortament.srtmName, dbo.r_rein_property.fillet_radius, 
                      dbo.r_rein_property.fillet_length, dbo.r_rein_property.rif_diameter, dbo.sortament.srtmID, dbo.sortament.srtmUsing
FROM         dbo.r_rein_property INNER JOIN
                      dbo.sortament ON dbo.r_rein_property.srtmID = dbo.sortament.srtmID INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.view_standard ON dbo.r_standard_posdef.stdID = dbo.view_standard.stdID INNER JOIN
                      dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID
GO
