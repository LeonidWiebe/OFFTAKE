SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_FH1_EmbPart_Wise_Group]
AS
SELECT     
		--dbo.elements.simID, 
		--dbo.elements.elemID, 
		--dbo.elements.pwdocID, 
		--dbo.elements.catitem, 
		--''AS 'Number',
	CASE
		When parts.dbo.part.typeID IS NULL Then dbo.i_EmbPart.CatalogName+' <-- нет в каталоге'
		When COUNT(Catal.catID)!=1 Then dbo.i_EmbPart.CatalogName+' <-- дублирование в катологах'
		Else dbo.i_EmbPart.CatalogName
	END AS 'Name from catalogue',
		
	CASE 
		WHEN parts.dbo.part.partDescr is null OR parts.dbo.part.partDescr = '' THEN '-'
		Else parts.dbo.part.partDescr
	END AS 'Drawing',

	CASE 
		WHEN parts.dbo.part.partSheet is null OR parts.dbo.part.partSheet = '' THEN 'N/A'
		Else parts.dbo.part.partSheet
	END AS 'Sheet number',

	COUNT(dbo.i_EmbPart.CatalogName)  as 'Count',

	aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.posCommonMass AS 'Unit weight',
	Round(SUM(aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.posCommonMass),1) AS 'Total weight', 
	root.nnn

FROM  dbo.elements 
LEFT OUTER JOIN dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID   
LEFT OUTER JOIN parts.dbo.part ON dbo.i_EmbPart.CatalogName = parts.dbo.part.partName
LEFT OUTER JOIN parts.dbo.position ON parts.dbo.part.partID = parts.dbo.position.partID
LEFT OUTER JOIN aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass ON parts.dbo.part.partID = aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.partID
LEFT OUTER JOIN aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake AS Catal ON parts.dbo.part.catID = Catal.catID
Left outer join aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake as root ON parts.dbo.part.catID = root.catID

WHERE  (dbo.elements.catitem='Embedded Part') and (parts.dbo.part.deleted = 0) and (parts.dbo.position.posNumber = 1) AND (parts.dbo.part.catID in (Select catID From aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake))
OR (parts.dbo.position.posNumber IS NULL) and (dbo.elements.catitem='Embedded Part')and (parts.dbo.part.deleted = 0) AND (parts.dbo.part.catID in (Select catID From aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake))
OR (parts.dbo.position.posNumber IS NULL) and (dbo.elements.catitem='Embedded Part')and (parts.dbo.part.deleted IS NULL) 


Group BY dbo.i_EmbPart.CatalogName
		,parts.dbo.part.typeID
		,parts.dbo.part.partDescr
		,parts.dbo.part.partSheet
		,aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.posCommonMass
		,Catal.catID
		,root.nnn
		





GO
