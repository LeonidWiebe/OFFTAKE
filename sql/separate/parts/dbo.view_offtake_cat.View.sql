SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_offtake_cat]
AS
SELECT     TOP (100) PERCENT dbo.r_catlist_part.catlistID, SUM(dbo.r_catlist_part.partQty * dbo.position.posCommonMass) AS mass, 
                      SUM(dbo.r_catlist_part.partQty * dbo.position.posQuantity) AS qty, dbo.part.partdefID, dbo.position.srtmID, dbo.position.matID, 
                      dbo.r_catlist_part.objID
FROM         dbo.part INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID INNER JOIN
                      dbo.r_catlist_part ON dbo.part.catID = dbo.r_catlist_part.partID
WHERE     (dbo.part.deleted = 0)
GROUP BY dbo.part.partdefID, dbo.position.srtmID, dbo.position.matID, dbo.r_catlist_part.catlistID, dbo.r_catlist_part.objID
HAVING      (dbo.r_catlist_part.objID = 7)
GO
