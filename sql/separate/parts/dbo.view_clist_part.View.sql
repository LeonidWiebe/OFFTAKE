SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_clist_part]
AS
SELECT     dbo.part.partName, dbo.r_catlist_part.partQty, dbo.part.partID, dbo.part.partSortNumber, dbo.part.catID, dbo.r_catlist_part.partSortID, 
                      dbo.catlist.catlistID, dbo.r_catlist_part.relID, dbo.catlist.catlistName, dbo.part.deleted, dbo.i_catalog.catUnif, dbo.i_catalog.catName, 
                      dbo.i_catalog.catTypeID, dbo.isPartRun(dbo.part.partID) AS partMainPosEP, dbo.r_catlist_part.objID, 
                      dbo.r_catlist_part.partQty * SUM(dbo.position.posCommonMass) AS mass, dbo.part.partdefID
FROM         dbo.part INNER JOIN
                      dbo.r_catlist_part ON dbo.part.partID = dbo.r_catlist_part.partID INNER JOIN
                      dbo.catlist ON dbo.r_catlist_part.catlistID = dbo.catlist.catlistID INNER JOIN
                      dbo.i_catalog ON dbo.part.catID = dbo.i_catalog.catID INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID
GROUP BY dbo.part.partName, dbo.r_catlist_part.partQty, dbo.part.partID, dbo.part.partSortNumber, dbo.part.catID, dbo.r_catlist_part.partSortID, 
                      dbo.catlist.catlistID, dbo.r_catlist_part.relID, dbo.catlist.catlistName, dbo.part.deleted, dbo.i_catalog.catUnif, dbo.i_catalog.catName, 
                      dbo.i_catalog.catTypeID, dbo.r_catlist_part.objID, dbo.part.partdefID
HAVING      (dbo.r_catlist_part.objID = 1)

GO
