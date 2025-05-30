SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admin_view_oper]
AS
SELECT        TOP (200) dbo.operationslog.oplogDate, dbo.usr.usrLogin, dbo.usr.usrFName, dbo.usr.usrName, dbo.operation.operName, dbo.object.objName, dbo.operationslog.what, dbo.operationslog.objectID, dbo.operationslog.objID
FROM            dbo.operationslog INNER JOIN
                         dbo.usr ON dbo.operationslog.usrID = dbo.usr.usrID INNER JOIN
                         dbo.operation ON dbo.operationslog.operID = dbo.operation.operID INNER JOIN
                         dbo.object ON dbo.operationslog.objID = dbo.object.objID
ORDER BY dbo.operationslog.oplogDate DESC
GO
