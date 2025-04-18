SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_offtable]
AS
SELECT     dbo.offtable.objectID, dbo.offtable.objID, dbo.offtable.mass, dbo.offtable.qty, dbo.offtable.partdefID, dbo.offtable.srtmID, dbo.offtable.matID, 
                      dbo.r_standard_posdef.stdID, dbo.r_standard_posdef.posdefID, dbo.sortament.srtmName, dbo.r_sortament_property.diameter, 
                      dbo.r_sortament_property.width, dbo.r_sortament_property.height, dbo.posdef.sortNumber, dbo.r_sortament_property.thickness, dbo.offtable.offtID, 
                      dbo.offtable.changes
FROM         dbo.offtable INNER JOIN
                      dbo.sortament ON dbo.offtable.srtmID = dbo.sortament.srtmID INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID LEFT OUTER JOIN
                      dbo.r_sortament_property ON dbo.offtable.srtmID = dbo.r_sortament_property.srtmID
GO
