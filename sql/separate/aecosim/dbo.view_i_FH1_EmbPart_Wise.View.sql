SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_FH1_EmbPart_Wise]
AS
SELECT     
		dbo.elements.simID AS simID, 
		dbo.elements.elemID, 
		dbo.elements.pwdocID, 
		dbo.elements.catitem, 
		''AS 'Number',
		dbo.i_EmbPart.PartCode AS 'KKS code', 
		dbo.i_EmbPart.CatalogName AS 'Name from catalogue', 
		--dbo.i_EmbPart.NuclearSafetyClass, 
		--dbo.i_EmbPart.SeismicClass, 
		--dbo.i_EmbPart.DesignWorkingLife, 
		--dbo.i_EmbPart.ConsequencesClass, 
		--dbo.i_EmbPart.ExecutionClass, 
		--dbo.i_EmbPart.ProductionCategory, 
		--dbo.i_EmbPart.ServiceCategory, 
		--dbo.i_EmbPart.AtmCorrCategory, 
		--dbo.i_EmbPart.CoatingSystem, 
		--dbo.i_EmbPart.DurabilityCoating, 
		--dbo.i_EmbPart.Drawing, 
		
		--parts.dbo.part.partID, 
		--parts.dbo.part.catID, 
		--parts.dbo.part.partdefID, 
		--parts.dbo.part.typeID, 
		
	CASE
		When parts.dbo.part.typeID IS NULL Then '<-- нет в каталоге'
		Else parts.dbo.dictionary.dicEng + ' / ' + parts.dbo.dictionary.dicRus 
	END AS 'Type',
		
		dbo.getEmbSection(parts.dbo.r_position_property.length,parts.dbo.r_position_property.thickness,parts.dbo.r_sortament_property.thickness,parts.dbo.r_sortament_property.horthickness,parts.dbo.r_sortament_property.verthickness,parts.dbo.r_position_property.width,parts.dbo.r_sortament_property.width,parts.dbo.r_sortament_property.diameter) AS 'Section',
		parts.dbo.view_r_material_standard.matName AS 'Material',
	CASE
		WHEN dbo.i_EmbPart.DurabilityCoating is not null OR dbo.i_EmbPart.DurabilityCoating != '' THEN 'Painted / Окрашено'
		Else ''
	END AS 'Surface Treatment',
		
		--parts.dbo.view_r_material_standard.stdFullNumber, 
		dbo.elements.pCentX, 
		dbo.elements.pCentY, 
		dbo.elements.pCentZ,
		
	CASE 
		WHEN parts.dbo.part.partDescr is null OR parts.dbo.part.partDescr = '' THEN '-'
		Else parts.dbo.part.partDescr
	END AS 'Drawing',
	CASE
		WHEN dbo.i_EmbPart.Supplier = 'AP' THEN 'Catalogue of typical products of JSC ATOMPROEKT / '+CHAR(10)+'Каталог типовых изделий АО "АТОМПРОЕКТ"'
		Else 'N/A'
	END AS 'Supplier'
		
		
		--parts.dbo.part.deleted
FROM  dbo.elements 


LEFT OUTER JOIN dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID   
LEFT  OUTER JOIN parts.dbo.part ON dbo.i_EmbPart.CatalogName = parts.dbo.part.partName
LEFT  OUTER JOIN parts.dbo.position ON parts.dbo.part.partID = parts.dbo.position.partID
LEFT  OUTER JOIN parts.dbo.sortament ON parts.dbo.sortament.srtmID = parts.dbo.position.srtmID
LEFT  OUTER JOIN parts.dbo.r_standard_posdef ON parts.dbo.sortament.stdposdefID = parts.dbo.r_standard_posdef.relID
LEFT OUTER JOIN parts.dbo.r_sortament_property ON parts.dbo.sortament.srtmID = parts.dbo.r_sortament_property.srtmID 
LEFT OUTER JOIN parts.dbo.view_r_material_standard ON parts.dbo.position.matID = parts.dbo.view_r_material_standard.matID 
LEFT OUTER JOIN parts.dbo.r_position_property ON parts.dbo.position.posID = parts.dbo.r_position_property.posID 
LEFT OUTER JOIN parts.dbo.parttype ON parts.dbo.part.typeID = parts.dbo.parttype.typeID
LEFT OUTER JOIN parts.dbo.dictionary ON parts.dbo.parttype.typeName = parts.dbo.dictionary.dicRus

WHERE  (dbo.elements.catitem='Embedded Part') and (parts.dbo.part.deleted = 0) and (parts.dbo.position.posNumber = 1) AND (parts.dbo.part.catID in (Select catID From aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake))
OR (parts.dbo.position.posNumber IS NULL) and (dbo.elements.catitem='Embedded Part')and (parts.dbo.part.deleted = 0) AND (parts.dbo.part.catID in (Select catID From aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake))
OR (parts.dbo.position.posNumber IS NULL) and (dbo.elements.catitem='Embedded Part')and (parts.dbo.part.deleted IS NULL) 


GO
