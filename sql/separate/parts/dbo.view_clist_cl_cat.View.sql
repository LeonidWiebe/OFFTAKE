SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_clist_cl_cat]
AS
SELECT     catlist_1.catlistName AS partName, dbo.r_catlist_part.partQty, dbo.r_catlist_part.partID, catlist_1.catlistName AS partSortNumber, catlist_1.catID, 
                      dbo.r_catlist_part.partSortID, dbo.catlist.catlistID, dbo.r_catlist_part.relID, dbo.catlist.catlistName, 0 AS deleted, 0 AS catUnif, '' AS catName, 
                      0 AS catTypeID, 0 AS partMainPosEP, dbo.r_catlist_part.objID, 
                      dbo.r_catlist_part.partQty * SUM(r_catlist_part_1.partQty * dbo.position.posCommonMass) AS mass, 0 AS partdefID
FROM         dbo.r_catlist_part INNER JOIN
                      dbo.catlist ON dbo.r_catlist_part.catlistID = dbo.catlist.catlistID INNER JOIN
                      dbo.r_catlist_part AS r_catlist_part_1 ON dbo.r_catlist_part.partID = r_catlist_part_1.catlistID INNER JOIN
                      dbo.position INNER JOIN
                      dbo.part ON dbo.position.partID = dbo.part.partID INNER JOIN
                      dbo.i_catalog ON dbo.part.catID = dbo.i_catalog.catID ON r_catlist_part_1.partID = dbo.i_catalog.catID INNER JOIN
                      dbo.catlist AS catlist_1 ON dbo.r_catlist_part.partID = catlist_1.catlistID
WHERE     (dbo.part.deleted = 0)
GROUP BY dbo.r_catlist_part.partQty, dbo.r_catlist_part.partSortID, dbo.catlist.catlistID, dbo.r_catlist_part.relID, dbo.catlist.catlistName, dbo.r_catlist_part.objID, 
                      catlist_1.catlistName, dbo.r_catlist_part.partID, catlist_1.catID, r_catlist_part_1.objID
HAVING      (dbo.r_catlist_part.objID = 14) AND (r_catlist_part_1.objID = 7)

GO
