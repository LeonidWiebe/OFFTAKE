SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_part]
AS
SELECT     dbo.part.catID, dbo.part.partID, dbo.part.partName, dbo.part.partdefID, dbo.partdef.partdefName, dbo.part.typeID, dbo.parttype.typeName, 
                      dbo.part.partDescr, dbo.part.partVersion, dbo.part.partSheet, dbo.part.deleted, dbo.part.partSortNumber, dbo.part.parentID, dbo.part.partStatusID, 
                      dbo.i_catalog.catName, parentpart.partName AS partNameOld, dbo.part.partIDold, dbo.part.catIDold, dbo.part.partRoundShift, dbo.part.partRoundSaved, 
                      dbo.docset.dsNumber AS dsPartList, docset_1.dsNumber AS dsDrawings, dbo.part.partMainPosEP
FROM         dbo.i_catalog INNER JOIN
                      dbo.part ON dbo.i_catalog.catID = dbo.part.catID LEFT OUTER JOIN
                      dbo.docset AS docset_1 ON dbo.part.dsDrawingsID = docset_1.dsID LEFT OUTER JOIN
                      dbo.docset ON dbo.part.dsPartListID = dbo.docset.dsID LEFT OUTER JOIN
                      dbo.part AS parentpart ON dbo.part.partIDold = parentpart.partID LEFT OUTER JOIN
                      dbo.parttype ON dbo.part.typeID = dbo.parttype.typeID LEFT OUTER JOIN
                      dbo.partdef ON dbo.part.partdefID = dbo.partdef.partdefID
GO
