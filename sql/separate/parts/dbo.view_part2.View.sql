SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_part2]
AS
SELECT     

catID, 
partID, 
partName, 
partdefID, 
partdefName, 
typeID, 
typeName, 
partDescr, 
partVersion, 
partSheet, 
deleted, 
partSortNumber, 
parentID, 
partStatusID, 
dsPartList, 
dsDrawings, 
partMainPosEP, 0 AS link

FROM         dbo.view_part

UNION

SELECT     

catID, 
partID, 
partName, 
partdefID, 
partdefName, 
typeID, 
typeName, 
partDescr, 
partVersion, 
partSheet, 
deleted, 
partSortNumber, 
parentID, 
partStatusID, 
dsPartList,
dsDrawings, 
partMainPosEP, 
linkID AS link

FROM         dbo.view_r_catalog_part

GO
