SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[view_i_EmbPart]
AS
--SELECT     dbo.elements.simID, dbo.elements.elemID, dbo.elements.pwdocID, dbo.elements.catitem, dbo.i_EmbPart.CatalogName, dbo.i_EmbPart.PartCode, 
--                      dbo.i_EmbPart.NuclearSafetyClass, dbo.i_EmbPart.SeismicClass, dbo.i_EmbPart.DesignWorkingLife, dbo.i_EmbPart.ConsequencesClass, 
--                      dbo.i_EmbPart.ExecutionClass, dbo.i_EmbPart.ProductionCategory, dbo.i_EmbPart.ServiceCategory, dbo.i_EmbPart.AtmCorrCategory, dbo.i_EmbPart.CoatingSystem, 
--                      dbo.i_EmbPart.DurabilityCoating, dbo.i_EmbPart.Drawing, dbo.i_EmbPart.Supplier, parts.dbo.part.partID, parts.dbo.part.catID, parts.dbo.part.partdefID, 
--                      parts.dbo.part.typeID, parts.dbo.r_position_property.thickness, parts.dbo.r_sortament_property.thickness AS s_thickness, 
--                      parts.dbo.r_sortament_property.horthickness AS s_horthickness, parts.dbo.r_sortament_property.verthickness AS s_verthickness, 
--                      parts.dbo.r_position_property.width, parts.dbo.r_sortament_property.width AS s_width, parts.dbo.r_sortament_property.diameter AS s_diameter, 
--                      parts.dbo.r_position_property.length, parts.dbo.view_r_material_standard.matName, parts.dbo.view_r_material_standard.stdFullNumber, dbo.elements.pCentX, 
--                      dbo.elements.pCentY, dbo.elements.pCentZ
--FROM         parts.dbo.r_standard_posdef RIGHT OUTER JOIN
--                      parts.dbo.sortament ON parts.dbo.r_standard_posdef.relID = parts.dbo.sortament.stdposdefID LEFT OUTER JOIN
--                      parts.dbo.r_sortament_property ON parts.dbo.sortament.srtmID = parts.dbo.r_sortament_property.srtmID RIGHT OUTER JOIN
--                      parts.dbo.position ON parts.dbo.sortament.srtmID = parts.dbo.position.srtmID LEFT OUTER JOIN
--                      parts.dbo.view_r_material_standard ON parts.dbo.position.matID = parts.dbo.view_r_material_standard.matID LEFT OUTER JOIN
--                      parts.dbo.r_position_property ON parts.dbo.position.posID = parts.dbo.r_position_property.posID RIGHT OUTER JOIN
--                      parts.dbo.part ON parts.dbo.position.partID = parts.dbo.part.partID RIGHT OUTER JOIN
--                      dbo.i_EmbPart INNER JOIN
--                      dbo.elements ON dbo.i_EmbPart.simID = dbo.elements.simID ON parts.dbo.part.partName = dbo.i_EmbPart.CatalogName
--WHERE     (parts.dbo.position.posNumber = 1) OR
--                      (parts.dbo.position.posNumber IS NULL)


SELECT 
      el.simID
      ,[elemID]
      ,[pwdocID]
      ,[catitem]
      ,ep.catalogname
      ,ep.partcode
      ,[pCentX]
      ,[pCentY]
      ,[pCentZ]
      ,[pMinX]
      ,[pMinY]
      ,[pMinZ]
      ,[pMaxX]
      ,[pMaxY]
      ,[pMaxZ]
	  ,[dbo].[getEmbSection]([pCentZ],[pCentX],NULL,NULL,NULL,NULL,[pCentY],NULL) AS Combo

  FROM [dbo].[elements] as el
  left outer join [dbo].[i_EmbPart] as ep on ep.simid=el.simID 
  where [cattype]='EmbeddedPart'






GO
