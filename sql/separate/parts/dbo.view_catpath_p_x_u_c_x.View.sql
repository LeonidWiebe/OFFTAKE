SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_catpath_p_x_u_c_x]
AS
SELECT     dbo.i_project.projectName + ' - ' + dbo.c_building.buildingCode + ' - ' + i_catalog_1.catName AS nnn, i_catalog_1.catID, i_catalog_1.deleted, 
                      dbo.c_building.buildingCode, dbo.i_project.projectID
FROM         dbo.i_project INNER JOIN
                      dbo.i_catalog AS i_catalog_1 INNER JOIN
                      dbo.r_object_catalog AS r_object_catalog_1 ON i_catalog_1.catID = r_object_catalog_1.catalogID INNER JOIN
                      dbo.i_building ON r_object_catalog_1.objectID = dbo.i_building.bldID INNER JOIN
                      dbo.c_building ON dbo.i_building.buildingID = dbo.c_building.buildingID ON dbo.i_project.projectID = dbo.i_building.objectID
WHERE     (r_object_catalog_1.objID = 8) AND (dbo.i_building.objID = 10)
GO
