SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_object_building]
AS
SELECT     dbo.i_building.objID, dbo.c_building.buildingCode, dbo.c_building.buildingName, dbo.i_building.bldID AS buildingID, dbo.i_building.objectID, 
                      dbo.c_building.typeID, dbo.i_building.deleted, dbo.c_building.buildingID AS cbldID
FROM         dbo.c_building INNER JOIN
                      dbo.i_building ON dbo.c_building.buildingID = dbo.i_building.buildingID
GO
