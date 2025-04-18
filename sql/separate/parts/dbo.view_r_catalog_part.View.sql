SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_r_catalog_part]
AS
SELECT        
dbo.r_catalog_part.catID, 
dbo.r_catalog_part.partID, 

-- if partLinkName is null use partName else partLinkName
--dbo.part.partName, 
CASE
	WHEN ISNULL(dbo.r_catalog_part.partLinkName,'')='' 
	THEN dbo.part.partName
	ELSE dbo.r_catalog_part.partLinkName
END AS partName, 

dbo.part.partdefID, 
dbo.partdef.partdefName, 
dbo.part.typeID, 
dbo.parttype.typeName, 
dbo.part.partDescr, 
dbo.part.partVersion, 
dbo.part.partSheet, 
dbo.part.deleted, 
dbo.part.partSortNumber, 
dbo.part.parentID, 
dbo.part.partStatusID, 
dbo.r_catalog_part.relID AS linkID, 
dbo.part.partRoundShift, 
dbo.part.partRoundSaved, 
dbo.docset.dsNumber AS dsPartList, 
docset_1.dsNumber AS dsDrawings, 
dbo.part.partMainPosEP

FROM            dbo.r_catalog_part 

INNER JOIN dbo.part ON dbo.r_catalog_part.partID = dbo.part.partID 
LEFT OUTER JOIN dbo.docset AS docset_1 ON dbo.part.dsDrawingsID = docset_1.dsID 
LEFT OUTER JOIN dbo.docset ON dbo.part.dsPartListID = dbo.docset.dsID 
LEFT OUTER JOIN dbo.parttype ON dbo.part.typeID = dbo.parttype.typeID 
LEFT OUTER JOIN dbo.partdef ON dbo.part.partdefID = dbo.partdef.partdefID

GO
