SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_clist_cl_part]
AS
SELECT     catlist_1.catlistName AS partName, r_catlist_part_1.partQty, r_catlist_part_1.partID, catlist_1.catlistName AS partSortNumber, catlist_1.catID, 
                      r_catlist_part_1.partSortID, dbo.catlist.catlistID, r_catlist_part_1.relID, dbo.catlist.catlistName, 0 AS deleted, 0 AS catUnif, '' AS catName, 
                      0 AS catTypeID, 0 AS partMainPosEP, r_catlist_part_1.objID, r_catlist_part_1.partQty * SUM(dbo.r_catlist_part.partQty * dbo.position.posCommonMass) 
                      AS mass, 0 AS partdefID
FROM         dbo.r_catlist_part INNER JOIN
                      dbo.catlist INNER JOIN
                      dbo.r_catlist_part AS r_catlist_part_1 ON dbo.catlist.catlistID = r_catlist_part_1.catlistID ON 
                      dbo.r_catlist_part.catlistID = r_catlist_part_1.partID INNER JOIN
                      dbo.catlist AS catlist_1 ON r_catlist_part_1.partID = catlist_1.catlistID INNER JOIN
                      dbo.part ON dbo.r_catlist_part.partID = dbo.part.partID INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID
GROUP BY r_catlist_part_1.partQty, r_catlist_part_1.partSortID, dbo.catlist.catlistID, r_catlist_part_1.relID, dbo.catlist.catlistName, catlist_1.catlistName, 
                      r_catlist_part_1.partID, catlist_1.catID, r_catlist_part_1.objID, dbo.r_catlist_part.objID
HAVING      (r_catlist_part_1.objID = 14) AND (dbo.r_catlist_part.objID = 1)

GO
