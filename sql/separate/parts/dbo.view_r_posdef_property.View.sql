SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_posdef_property]
AS
SELECT     dbo.r_posdef_property.relID, dbo.posdef.posdefName, dbo.r_posdef_property.sortOrder, dbo.property.propName, dbo.property.propDescr, 
                      dbo.object.objDescription, dbo.r_posdef_property.posdefID, dbo.r_posdef_property.propID, dbo.r_posdef_property.objectID, 
                      dbo.posdef.posdefDrawName, dbo.posdef.posdefDrawSign, dbo.propertyvalue.propvalName, dbo.property.propDefValue, dbo.property.muID, 
                      dbo.property.tableName, dbo.property.muIDsrtm
FROM         dbo.propertyvalue RIGHT OUTER JOIN
                      dbo.property ON dbo.propertyvalue.propvalID = dbo.property.propValue RIGHT OUTER JOIN
                      dbo.r_posdef_property ON dbo.property.propID = dbo.r_posdef_property.propID LEFT OUTER JOIN
                      dbo.posdef ON dbo.r_posdef_property.posdefID = dbo.posdef.posdefID LEFT OUTER JOIN
                      dbo.object ON dbo.r_posdef_property.objectID = dbo.object.objID
GO
