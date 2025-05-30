SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_ED_EmbPart]
AS
SELECT     
		dbo.elements.simID, 
		dbo.elements.elemID, 
		dbo.elements.pwdocID, 
		--dbo.elements.catitem, 
		dbo.i_EmbPart.CatalogName, 
		p.partName, 
		dbo.i_EmbPart.PartCode, 
		dbo.i_EmbPlate.Length, 
		dbo.i_EmbPlate.Width, 
		dbo.i_EmbPlate.Thickness, 
		p.partID, 
		p.catID, 
		p.partdefID, 
		p.typeID, 
		--parts.dbo.r_position_property.thickness, 
		--parts.dbo.r_sortament_property.thickness AS s_thickness,
		--parts.dbo.r_sortament_property.horthickness AS s_horthickness, 
		--parts.dbo.r_sortament_property.verthickness AS s_verthickness, 
		--parts.dbo.r_position_property.width, 
		--parts.dbo.r_sortament_property.width AS s_width, 
		--parts.dbo.r_sortament_property.diameter AS s_diameter, 
		--parts.dbo.r_position_property.length, 
		--parts.dbo.view_r_material_standard.matName, 
		--parts.dbo.view_r_material_standard.stdFullNumber, 
		dbo.elements.pCentX, 
		dbo.elements.pCentY, 
		dbo.elements.pCentZ
FROM  dbo.elements

inner JOIN dbo.i_EmbPart on dbo.i_EmbPart.simID = dbo.elements.simID
inner JOIN dbo.i_EmbPlate on dbo.i_EmbPlate.simID = dbo.elements.simID

inner JOIN parts.dbo.part p ON dbo.i_EmbPart.partID = p.partID 


GO
