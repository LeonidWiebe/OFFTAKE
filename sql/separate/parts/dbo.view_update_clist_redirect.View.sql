SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_update_clist_redirect]
AS
SELECT     dbo.catlist.catID, dbo.r_catlist_part.relID, dbo.r_catlist_part.catlistID, dbo.r_catlist_part.partID, dbo.r_catlist_part.partQty, dbo.r_catlist_part.partSortID, 
                      dbo.r_catlist_part.objID, dbo.part.partID AS Expr1
FROM         dbo.r_catlist_part INNER JOIN
                      dbo.catlist ON dbo.r_catlist_part.catlistID = dbo.catlist.catlistID INNER JOIN
                      dbo.part ON dbo.catlist.catID = dbo.part.catID AND dbo.r_catlist_part.partID = dbo.part.partIDold

GO
