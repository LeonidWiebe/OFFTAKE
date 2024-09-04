SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_catpath_p_b_x_c_c]
AS
SELECT     dbo.i_project.projectName + ' - Блок ' + CAST(dbo.i_block.blockNumber AS varchar(10)) 
                      + ' - ' + i_catalog_1.catName + ' - ' + dbo.i_catalog.catName AS nnn, dbo.i_catalog.catID, dbo.i_catalog.deleted, '' AS buildingCode, 
                      dbo.i_project.projectID
FROM         dbo.r_object_catalog AS r_object_catalog_1 INNER JOIN
                      dbo.i_catalog INNER JOIN
                      dbo.r_object_catalog ON dbo.i_catalog.catID = dbo.r_object_catalog.catalogID INNER JOIN
                      dbo.i_catalog AS i_catalog_1 ON dbo.r_object_catalog.objectID = i_catalog_1.catID ON r_object_catalog_1.catalogID = i_catalog_1.catID INNER JOIN
                      dbo.i_block INNER JOIN
                      dbo.i_project ON dbo.i_block.projectID = dbo.i_project.projectID ON r_object_catalog_1.objectID = dbo.i_block.blockID
WHERE     (dbo.r_object_catalog.objID = 7) AND (r_object_catalog_1.objID = 9)
GO
