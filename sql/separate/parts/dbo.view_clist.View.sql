SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_clist]
AS
SELECT     partName, partQty, partID, partSortNumber, catID, partSortID, catlistID, relID, catlistName, deleted, catUnif, catName, catTypeID, partMainPosEP, objID, 
                      mass, partdefID
FROM         dbo.view_clist_part
UNION
SELECT     partName, partQty, partID, partSortNumber, catID, partSortID, catlistID, relID, catlistName, deleted, catUnif, catName, catTypeID, partMainPosEP, objID, 
                      mass, partdefID
FROM         dbo.view_clist_cat
UNION
SELECT     partName, partQty, partID, partSortNumber, catID, partSortID, catlistID, relID, catlistName, deleted, catUnif, catName, catTypeID, partMainPosEP, objID, 
                      sum(mass), partdefID
FROM         dbo.view_clist_clist
GROUP BY partName, partQty, partID, partSortNumber, catID, partSortID, catlistID, relID, catlistName, deleted, catUnif, catName, catTypeID, partMainPosEP, objID, partdefID

GO
