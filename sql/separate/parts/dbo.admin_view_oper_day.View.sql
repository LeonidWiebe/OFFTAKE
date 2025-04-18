SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admin_view_oper_day]
AS
SELECT     TOP (100) dbo.usr.usrLogin, COUNT(*) AS cnt, MAX(dbo.operationslog.oplogDate) AS mx
FROM         dbo.usr INNER JOIN
                      dbo.operationslog ON dbo.usr.usrID = dbo.operationslog.usrID
WHERE     (DAY(dbo.operationslog.oplogDate) = DAY(CURRENT_TIMESTAMP)) AND (MONTH(dbo.operationslog.oplogDate) = MONTH(CURRENT_TIMESTAMP)) 
                      AND (YEAR(dbo.operationslog.oplogDate) = YEAR(CURRENT_TIMESTAMP))
GROUP BY dbo.usr.usrLogin, DAY(dbo.operationslog.oplogDate), MONTH(dbo.operationslog.oplogDate), YEAR(dbo.operationslog.oplogDate)
ORDER BY mx DESC
GO
