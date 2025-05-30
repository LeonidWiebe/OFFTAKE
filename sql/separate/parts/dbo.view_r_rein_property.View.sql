SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_rein_property]
AS
SELECT     dbo.sortament.srtmName, dbo.r_rein_property.fillet_radius, dbo.r_rein_property.fillet_length, dbo.r_rein_property.rif_diameter
FROM         dbo.r_rein_property INNER JOIN
                      dbo.sortament ON dbo.r_rein_property.srtmID = dbo.sortament.srtmID
GO
