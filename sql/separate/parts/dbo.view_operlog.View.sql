SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_operlog]
AS
SELECT     dbo.operation.operDescr, dbo.usr.usrLogin, dbo.operationslog.oplogDate, dbo.operationslog.objectID, dbo.operationslog.objID, 
                      dbo.operationslog.usrID, dbo.operationslog.what
FROM         dbo.operationslog INNER JOIN
                      dbo.operation ON dbo.operationslog.operID = dbo.operation.operID INNER JOIN
                      dbo.usr ON dbo.operationslog.usrID = dbo.usr.usrID

GO
