SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_catlist]
AS
SELECT     TOP (100) PERCENT dbo.r_catlist_part.catlistID, dbo.r_catlist_part.partQty, SUM(dbo.position.posCommonMass) AS mass, dbo.r_catlist_part.partSortID,
                       dbo.r_catlist_part.partID, dbo.part.partdefID, dbo.r_catlist_part.objID
FROM         dbo.position INNER JOIN
                      dbo.part ON dbo.position.partID = dbo.part.partID INNER JOIN
                      dbo.r_catlist_part ON dbo.part.partID = dbo.r_catlist_part.partID
GROUP BY dbo.r_catlist_part.partQty, dbo.r_catlist_part.catlistID, dbo.r_catlist_part.partSortID, dbo.r_catlist_part.partID, dbo.part.partdefID, 
                      dbo.r_catlist_part.objID
GO
