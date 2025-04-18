SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admin_view_oper_cat]
AS
SELECT        TOP (100) dbo.operationslog.oplogDate, dbo.usr.usrLogin, dbo.usr.usrFName, dbo.usr.usrName, dbo.operation.operName, dbo.operationslog.what, dbo.view_catpath.nnn, dbo.view_catpath.deleted
FROM            dbo.operationslog INNER JOIN
                         dbo.operation ON dbo.operationslog.operID = dbo.operation.operID INNER JOIN
                         dbo.usr ON dbo.operationslog.usrID = dbo.usr.usrID INNER JOIN
                         dbo.object ON dbo.operationslog.objID = dbo.object.objID INNER JOIN
                         dbo.view_catpath ON dbo.operationslog.objectID = dbo.view_catpath.catID
WHERE        (dbo.object.objName = 'catalog')
ORDER BY dbo.operationslog.oplogDate DESC
GO
