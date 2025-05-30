SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_type_object]
AS
SELECT     dbo.typelist.typeName, dbo.object.objName, dbo.object.objID, dbo.typelist.typeID
FROM         dbo.typelist RIGHT OUTER JOIN
                      dbo.[type-object] ON dbo.typelist.typeID = dbo.[type-object].typeID LEFT OUTER JOIN
                      dbo.object ON dbo.[type-object].objectID = dbo.object.objID
GO
