SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_clist_cat]
AS
SELECT     dbo.i_catalog.catName AS partName, dbo.r_catlist_part.partQty, dbo.i_catalog.catID AS partID, dbo.i_catalog.catName AS partSortNumber, 
                      dbo.i_catalog.catID, dbo.r_catlist_part.partSortID, dbo.catlist.catlistID, dbo.r_catlist_part.relID, dbo.catlist.catlistName, dbo.i_catalog.deleted, 
                      dbo.i_catalog.catUnif, dbo.i_catalog.catName, dbo.i_catalog.catTypeID, 0 AS partMainPosEP, dbo.r_catlist_part.objID, 
                      SUM(dbo.position.posCommonMass) * dbo.r_catlist_part.partQty AS mass, 0 AS partdefID
FROM         dbo.position INNER JOIN
                      dbo.part ON dbo.position.partID = dbo.part.partID RIGHT OUTER JOIN
                      dbo.r_catlist_part INNER JOIN
                      dbo.catlist ON dbo.r_catlist_part.catlistID = dbo.catlist.catlistID INNER JOIN
                      dbo.i_catalog ON dbo.r_catlist_part.partID = dbo.i_catalog.catID ON dbo.part.catID = dbo.i_catalog.catID
WHERE     (dbo.part.deleted = 0) OR
                      (dbo.part.deleted IS NULL)
GROUP BY dbo.i_catalog.catName, dbo.r_catlist_part.partQty, dbo.i_catalog.catID, dbo.r_catlist_part.partSortID, dbo.catlist.catlistID, dbo.r_catlist_part.relID, 
                      dbo.catlist.catlistName, dbo.i_catalog.deleted, dbo.i_catalog.catUnif, dbo.i_catalog.catTypeID, dbo.r_catlist_part.objID
HAVING      (dbo.r_catlist_part.objID = 7)

GO
