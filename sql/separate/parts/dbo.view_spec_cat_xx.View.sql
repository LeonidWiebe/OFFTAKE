SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_cat_xx]
AS
SELECT     TOP (100) PERCENT dbo.r_catlist_part.catlistID, dbo.partdef.partdefNameMulti, dbo.part.partName, dbo.part.partDescr, dbo.part.partSheet, 
                      dbo.part.partMainPosEP, dbo.r_catlist_part.partQty, SUM(dbo.position.posCommonMass) AS mass, dbo.r_catlist_part.partSortID, 
                      dbo.r_catlist_part.partID, dbo.partdef.partdefID
FROM         dbo.position INNER JOIN
                      dbo.part ON dbo.position.partID = dbo.part.partID INNER JOIN
                      dbo.r_catlist_part ON dbo.part.partID = dbo.r_catlist_part.partID INNER JOIN
                      dbo.sortament ON dbo.position.srtmID = dbo.sortament.srtmID LEFT OUTER JOIN
                      dbo.partdef ON dbo.part.partdefID = dbo.partdef.partdefID
GROUP BY dbo.part.partName, dbo.part.partDescr, dbo.part.partSheet, dbo.r_catlist_part.partQty, dbo.r_catlist_part.catlistID, dbo.r_catlist_part.partSortID, 
                      dbo.part.partMainPosEP, dbo.partdef.partdefNameMulti, dbo.r_catlist_part.partID, dbo.partdef.partdefID
ORDER BY dbo.r_catlist_part.partSortID
GO
