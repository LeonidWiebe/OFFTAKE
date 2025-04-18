SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[admin_view_oper_srtm]
AS
SELECT     TOP (100) PERCENT dbo.usr.usrLogin, dbo.operationslog.oplogDate, dbo.sortament.srtmName, dbo.standard.stdNumber, dbo.standard.stdName, 
                      dbo.operationslog.what
FROM         dbo.operationslog INNER JOIN
                      dbo.object ON dbo.operationslog.objID = dbo.object.objID INNER JOIN
                      dbo.sortament ON dbo.operationslog.objectID = dbo.sortament.srtmID INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.standard ON dbo.r_standard_posdef.stdID = dbo.standard.stdID INNER JOIN
                      dbo.usr ON dbo.operationslog.usrID = dbo.usr.usrID
WHERE     (dbo.object.objName = 'srtm')
--order by oplogDate desc
GO
