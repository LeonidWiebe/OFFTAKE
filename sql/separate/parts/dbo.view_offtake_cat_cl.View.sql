SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_offtake_cat_cl]
AS
SELECT     TOP (100) PERCENT dbo.r_catlist_part.catlistID, SUM(dbo.r_catlist_part.partQty * r_catlist_part_1.partQty * dbo.position.posCommonMass) AS mass, 
                      SUM(dbo.r_catlist_part.partQty * r_catlist_part_1.partQty * dbo.position.posQuantity) AS qty, dbo.part.partdefID, dbo.position.srtmID, 
                      dbo.position.matID, dbo.r_catlist_part.objID
FROM         dbo.r_catlist_part AS r_catlist_part_1 INNER JOIN
                      dbo.r_catlist_part ON r_catlist_part_1.catlistID = dbo.r_catlist_part.partID INNER JOIN
                      dbo.part INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID ON r_catlist_part_1.partID = dbo.part.catID
WHERE     (dbo.part.deleted = 0)
GROUP BY dbo.part.partdefID, dbo.position.srtmID, dbo.position.matID, dbo.r_catlist_part.catlistID, dbo.r_catlist_part.objID, r_catlist_part_1.objID
HAVING      (dbo.r_catlist_part.objID = 14) AND (r_catlist_part_1.objID = 7)
GO
