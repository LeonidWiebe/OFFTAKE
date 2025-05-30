SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_part_pos_property]
AS
SELECT     TOP (100) PERCENT dbo.view_part2.catID, dbo.view_part2.partID, dbo.view_part2.partName, dbo.view_part2.deleted, dbo.r_position_property.width, 
                      dbo.r_sortament_property.width AS srtmwidth, dbo.r_position_property.length AS listlen, dbo.r_sortament_property.thickness, 
                      r_position_property_1.length AS anklen, r_sortament_property_1.diameter, dbo.view_part2.partVersion, dbo.view_part2.partSortNumber
FROM         dbo.r_standard_posdef INNER JOIN
                      dbo.sortament ON dbo.r_standard_posdef.relID = dbo.sortament.stdposdefID INNER JOIN
                      dbo.view_part2 INNER JOIN
                      dbo.position AS pos1 ON dbo.view_part2.partID = pos1.partID INNER JOIN
                      dbo.position AS pos2 ON dbo.view_part2.partID = pos2.partID ON dbo.sortament.srtmID = pos2.srtmID INNER JOIN
                      dbo.sortament AS sortament_1 ON pos1.srtmID = sortament_1.srtmID INNER JOIN
                      dbo.r_standard_posdef AS r_standard_posdef_1 ON sortament_1.stdposdefID = r_standard_posdef_1.relID LEFT OUTER JOIN
                      dbo.r_sortament_property ON pos1.srtmID = dbo.r_sortament_property.srtmID LEFT OUTER JOIN
                      dbo.r_position_property ON pos1.posID = dbo.r_position_property.posID LEFT OUTER JOIN
                      dbo.r_sortament_property AS r_sortament_property_1 ON pos2.srtmID = r_sortament_property_1.srtmID LEFT OUTER JOIN
                      dbo.r_position_property AS r_position_property_1 ON pos2.posID = r_position_property_1.posID
WHERE     (pos1.posNumber = 1) AND (dbo.r_standard_posdef.posdefID = 1) AND (r_standard_posdef_1.posdefID = 8 OR
                      r_standard_posdef_1.posdefID = 2 OR
                      r_standard_posdef_1.posdefID = 10) AND (dbo.view_part2.deleted = 0)
ORDER BY dbo.view_part2.partSortNumber
GO
