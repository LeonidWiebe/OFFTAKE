SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_copy_5]
AS
SELECT     dbo.r_catlist_part.partQty, dbo.r_catlist_part.partSortID, dbo.r_catlist_part.objID, dbo.catlist.catID, dbo.catlist.catlistID, dbo.r_catlist_part.partID
FROM         dbo.r_catlist_part INNER JOIN
                      dbo.catlist ON dbo.r_catlist_part.catlistID = dbo.catlist.clIDold

GO
