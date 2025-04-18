SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[view_i_FH1_EmbPart_Wise_Group2]
AS
SELECT     
		dbo.elements.simID, 
		dbo.elements.elemID, 
		dbo.elements.pwdocID, 
		Catal.catID,
		Catal.nnn,
		parts.dbo.part.partID,
		dbo.elements.catitem, 
		--''AS 'Number',
		--Catal.catID AS 'CatID',
		
		
	CASE
		When parts.dbo.part.typeID IS NULL Then dbo.i_EmbPart.CatalogName+' <-- нет в каталоге'
		--When Con.catID != 1 Then dbo.i_EmbPart.CatalogName+ ' <-- дублирование в катологах'
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


	dbo.i_EmbPart.CatalogName  as 'Count',

	aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.posCommonMass AS 'Unit weight',
	aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.posCommonMass AS 'Total weight' 

FROM  dbo.elements 
LEFT OUTER JOIN dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID     -------i_EmbPart v
LEFT OUTER JOIN parts.dbo.part ON dbo.i_EmbPart.CatalogName = parts.dbo.part.partName -----------part v

LEFT OUTER JOIN aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass ON parts.dbo.part.partID = aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.partID --view_i_FH1_EmbPart_Wise_Mass
LEFT OUTER JOIN aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake AS Catal ON parts.dbo.part.catID = Catal.catID -----view_i_FH1_EmbPart_Wise_Offtake--------------------Catal
LEFT OUTER JOIN aecosim.dbo.view_i_FH1_EmbPart_Wise_Cat AS Con ON dbo.i_EmbPart.CatalogName = Con.partName --------view_i_FH1_EmbPart_Wise_Cat---------------------Con


--LEFT OUTER JOIN parts.dbo.position ON parts.dbo.part.partID = parts.dbo.position.partID ----------position v проблема с этой таблицей

WHERE  

((dbo.elements.catitem='Embedded Part') 
AND (parts.dbo.part.deleted = 0) 
AND (parts.dbo.part.catID in (Select catID From aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake)))
--or
--((parts.dbo.position.posNumber IS NULL) 
--AND (dbo.elements.catitem='Embedded Part')
--AND (parts.dbo.part.deleted = 0) 
--AND (parts.dbo.part.catID in (Select catID From aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake)))

--OR ((parts.dbo.position.posNumber IS NULL) 
--AND (dbo.elements.catitem='Embedded Part')
--AND (parts.dbo.part.deleted IS NULL) )


--Group BY dbo.i_EmbPart.CatalogName
--		,parts.dbo.part.typeID
--		,parts.dbo.part.partDescr
--		,parts.dbo.part.partSheet
--		,aecosim.dbo.view_i_FH1_EmbPart_Wise_Mass.posCommonMass








GO
