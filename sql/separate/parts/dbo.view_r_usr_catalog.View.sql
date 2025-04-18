SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_usr_catalog]
AS
SELECT     dbo.usr.usrLogin, dbo.usr.usrFName, dbo.usr.usrName, dbo.r_usr_catalog.usrID, dbo.r_usr_catalog.catID, dbo.usr.groupID, dbo.r_usr_catalog.relID, 
                      dbo.i_catalog.catName, dbo.i_catalog.deleted
FROM         dbo.r_usr_catalog LEFT OUTER JOIN
                      dbo.usr ON dbo.r_usr_catalog.usrID = dbo.usr.usrID LEFT OUTER JOIN
                      dbo.i_catalog ON dbo.r_usr_catalog.catID = dbo.i_catalog.catID
GO
