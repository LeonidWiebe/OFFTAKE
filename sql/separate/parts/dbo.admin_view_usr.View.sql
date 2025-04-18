SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[admin_view_usr]
AS
SELECT        TOP (100) dbo.usr.usrLogin, dbo.usr.usrFName, dbo.usr.usrName, dbo.department.depName, dbo.usr.compName, dbo.usr.usrTime, dbo.i_group.groupName, dbo.usr.usedNative, dbo.view_catpath.nnn
FROM            dbo.usr INNER JOIN
                         dbo.view_catpath ON dbo.usr.usrCatalogID = dbo.view_catpath.catID LEFT OUTER JOIN
                         dbo.i_group ON dbo.usr.groupID = dbo.i_group.groupID LEFT OUTER JOIN
                         dbo.department ON dbo.usr.depID = dbo.department.depID
WHERE        (dbo.usr.compName IS NOT NULL)
ORDER BY dbo.usr.usrTime DESC
GO
