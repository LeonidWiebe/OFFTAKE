SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_part_kks_bld]
AS
SELECT     dbo.r_part_kks.kksID, dbo.r_part_kks.kksSys, dbo.r_part_kks.kksNum, dbo.r_part_kks.partID, dbo.r_part_kks.formrow, dbo.r_part_kks.formcol, i_block_1.blockID, 
                      i_block_1.blockNumber, i_block_1.projectID, dbo.part.partName, dbo.part.catID, dbo.partdef.kksDiv, dbo.part.deleted, dbo.i_catalog.deleted AS catdel
FROM         dbo.partdef INNER JOIN
                      dbo.r_part_kks INNER JOIN
                      dbo.part ON dbo.r_part_kks.partID = dbo.part.partID ON dbo.partdef.partdefID = dbo.part.partdefID INNER JOIN
                      dbo.i_catalog ON dbo.part.catID = dbo.i_catalog.catID LEFT OUTER JOIN
                      dbo.i_building LEFT OUTER JOIN
                      dbo.i_block AS i_block_1 ON dbo.i_building.objectID = i_block_1.blockID RIGHT OUTER JOIN
                      dbo.r_object_catalog AS r_object_catalog_1 ON dbo.i_building.bldID = r_object_catalog_1.objectID ON dbo.part.catID = r_object_catalog_1.catalogID
WHERE     (r_object_catalog_1.objID = 8) AND (dbo.i_building.objID = 9)
GO
