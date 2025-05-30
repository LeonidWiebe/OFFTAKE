SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admin_view_oper_position]
AS
SELECT     TOP (200) dbo.operationslog.oplogDate, dbo.usr.usrLogin, dbo.operation.operName, dbo.operationslog.what, dbo.position.posID, dbo.part.partName, 
                      dbo.view_catpath.nnn, dbo.part.catID
FROM         dbo.operationslog INNER JOIN
                      dbo.operation ON dbo.operationslog.operID = dbo.operation.operID INNER JOIN
                      dbo.position ON dbo.operationslog.objectID = dbo.position.posID INNER JOIN
                      dbo.object ON dbo.operationslog.objID = dbo.object.objID INNER JOIN
                      dbo.usr ON dbo.operationslog.usrID = dbo.usr.usrID INNER JOIN
                      dbo.part ON dbo.position.partID = dbo.part.partID INNER JOIN
                      dbo.view_catpath ON dbo.part.catID = dbo.view_catpath.catID
WHERE     (dbo.object.objName = 'position')
ORDER BY dbo.operationslog.oplogDate DESC
GO
