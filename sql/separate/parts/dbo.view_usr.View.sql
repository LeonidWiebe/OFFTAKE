SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_usr]
AS
SELECT     dbo.usr.usrID, dbo.usr.usrLogin, dbo.usr.usrFName, dbo.usr.usrName, dbo.usr.usrOName, dbo.department.depName, dbo.usr.groupID, 
                      dbo.usr.depID
FROM         dbo.usr INNER JOIN
                      dbo.department ON dbo.usr.depID = dbo.department.depID
GO
