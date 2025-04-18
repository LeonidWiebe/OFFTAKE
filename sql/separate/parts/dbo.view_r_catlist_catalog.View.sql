SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_catlist_catalog]
AS
SELECT     dbo.catlist.catlistID, dbo.catlist.catID, dbo.catlist.catlistName, dbo.catlist.deleted, dbo.i_catalog.catID AS catDefID, dbo.catlist.clPassive
FROM         dbo.i_catalog RIGHT OUTER JOIN
                      dbo.catlist ON dbo.i_catalog.catlistID = dbo.catlist.catlistID
GO
