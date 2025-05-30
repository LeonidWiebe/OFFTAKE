SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_rein_catlist]
AS
SELECT     TOP (100) PERCENT dbo.r_catlist_part.catlistID, dbo.r_catlist_part.partQty, SUM(dbo.position.posCommonMass) AS mass, dbo.r_catlist_part.partSortID,
                       dbo.r_catlist_part.partID, dbo.part.partdefID, dbo.r_catlist_part.objID
FROM         dbo.i_catalog INNER JOIN
                      dbo.r_catlist_part ON dbo.i_catalog.catID = dbo.r_catlist_part.partID INNER JOIN
                      dbo.position INNER JOIN
                      dbo.part ON dbo.position.partID = dbo.part.partID ON dbo.i_catalog.catID = dbo.part.catID
WHERE     (dbo.part.deleted = 0)
GROUP BY dbo.r_catlist_part.partQty, dbo.r_catlist_part.catlistID, dbo.r_catlist_part.partSortID, dbo.r_catlist_part.partID, dbo.part.partdefID, 
                      dbo.r_catlist_part.objID
GO
