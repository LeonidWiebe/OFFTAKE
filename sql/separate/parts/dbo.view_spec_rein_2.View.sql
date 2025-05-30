SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_rein_2]
AS
SELECT     TOP (100) PERCENT dbo.part.catID, dbo.part.partID, dbo.position.posID, dbo.part.partName, dbo.position.srtmID, dbo.position.matID, dbo.part.deleted, 
                      dbo.position.posQuantity, dbo.position.posUnitMass, dbo.position.posCommonMass, dbo.position.numDigits, dbo.position.posUMCalc, 
                      dbo.position.posCMCalc, dbo.position.posNumber, dbo.partdef.partdefNameMulti, dbo.r_sortament_property.masslength, 
                      dbo.r_sortament_property.massunit, dbo.r_sortament_property.massvolume, dbo.r_position_property.length, dbo.r_position_property.width, 
                      dbo.part.partSortNumber, dbo.sortament.srtmName, dbo.r_sortament_property.diameter, dbo.r_standard_posdef.posdefID, dbo.position.posSketch, 
                      dbo.position.posBarLength, dbo.part.partRoundShift, dbo.part.partRoundSaved, dbo.position.mcID, dbo.r_position_property.radiusinn, 
                      dbo.r_rein_property.fillet_radius, dbo.r_position_property.lenmin, dbo.r_position_property.lenmax, dbo.r_position_property.lenmid
FROM         dbo.r_standard_posdef INNER JOIN
                      dbo.sortament ON dbo.r_standard_posdef.relID = dbo.sortament.stdposdefID RIGHT OUTER JOIN
                      dbo.position LEFT OUTER JOIN
                      dbo.r_rein_property ON dbo.position.srtmID = dbo.r_rein_property.srtmID ON dbo.sortament.srtmID = dbo.position.srtmID LEFT OUTER JOIN
                      dbo.r_sortament_property ON dbo.position.srtmID = dbo.r_sortament_property.srtmID LEFT OUTER JOIN
                      dbo.r_position_property ON dbo.position.posID = dbo.r_position_property.posID RIGHT OUTER JOIN
                      dbo.partdef RIGHT OUTER JOIN
                      dbo.part ON dbo.partdef.partdefID = dbo.part.partdefID ON dbo.position.partID = dbo.part.partID
WHERE     (dbo.part.deleted = 0)
ORDER BY dbo.part.partSortNumber
GO
