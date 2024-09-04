SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_clist_clist]
AS
SELECT     partName, partQty, partID, partSortNumber, catID, partSortID, catlistID, relID, catlistName, deleted, catUnif, catName, catTypeID, partMainPosEP, objID, 
                      mass, partdefID
FROM         dbo.view_clist_cl_cat
UNION ALL
SELECT     partName, partQty, partID, partSortNumber, catID, partSortID, catlistID, relID, catlistName, deleted, catUnif, catName, catTypeID, partMainPosEP, objID, 
                      mass, partdefID
FROM         dbo.view_clist_cl_part

GO
