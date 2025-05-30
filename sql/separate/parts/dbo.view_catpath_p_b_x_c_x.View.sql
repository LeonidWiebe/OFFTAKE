SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_catpath_p_b_x_c_x]
AS
SELECT     dbo.i_project.projectName + ' - Блок ' + CAST(dbo.i_block.blockNumber AS varchar(10)) + ' - ' + i_catalog_1.catName AS nnn, i_catalog_1.catID, 
                      i_catalog_1.deleted, '' AS buildingCode, dbo.i_project.projectID
FROM         dbo.i_project INNER JOIN
                      dbo.i_block ON dbo.i_project.projectID = dbo.i_block.projectID INNER JOIN
                      dbo.i_catalog AS i_catalog_1 INNER JOIN
                      dbo.r_object_catalog AS r_object_catalog_1 ON i_catalog_1.catID = r_object_catalog_1.catalogID ON 
                      dbo.i_block.blockID = r_object_catalog_1.objectID
WHERE     (r_object_catalog_1.objID = 9)
GO
