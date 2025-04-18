SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_property]
AS
SELECT     dbo.property.propID, dbo.propertyvalue.propvalID, dbo.measureunit.muID, dbo.property.propName, dbo.property.propDescr, dbo.propertyvalue.propvalName, 
                      dbo.measureunit.muName, dbo.measureunit.muShortName, dbo.property.propDefValue, dbo.measureunit.muSiK, dbo.property.muIDsrtm, dbo.property.tableName, 
                      dbo.property.using, dbo.property.objID
FROM         dbo.property LEFT OUTER JOIN
                      dbo.propertyvalue ON dbo.property.propValue = dbo.propertyvalue.propvalID LEFT OUTER JOIN
                      dbo.measureunit ON dbo.property.muID = dbo.measureunit.muID
GO
