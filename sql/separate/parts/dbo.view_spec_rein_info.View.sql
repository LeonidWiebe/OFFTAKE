SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_rein_info]
AS
SELECT        TOP (100) PERCENT dbo.part.catID, dbo.part.partID, dbo.position.posID, dbo.part.partName, dbo.position.srtmID, dbo.position.matID, dbo.part.deleted, dbo.position.posQuantity, dbo.position.posUnitMass, 
                         dbo.position.posCommonMass, dbo.position.numDigits, dbo.position.posUMCalc, dbo.position.posCMCalc, dbo.position.posNumber, dbo.partdef.partdefNameMulti, dbo.r_sortament_property.masslength, 
                         dbo.r_sortament_property.massunit, dbo.r_sortament_property.massvolume, dbo.r_position_property.length, dbo.r_position_property.width, dbo.part.partSortNumber, dbo.sortament.srtmName, 
                         dbo.r_sortament_property.diameter, dbo.r_standard_posdef.posdefID, dbo.position.posSketch, dbo.position.posBarLength, dbo.part.partRoundShift, dbo.part.partRoundSaved, dbo.position.mcID, 
                         dbo.r_position_property.radiusinn, dbo.r_rein_property.fillet_radius, dbo.r_position_property.lenmin, dbo.r_position_property.lenmax, dbo.r_position_property.lenmid, dbo.r_part_reinpoints.xd, dbo.r_part_reinpoints.yd, 
                         dbo.r_part_reinpoints.zd, dbo.r_part_reinpoints.isMain, dbo.r_part_reinpoints.isCont, dbo.r_part_reinsketch.sketchStartType, dbo.r_part_reinsketch.sketchEndType, dbo.r_part_reinsketch.sketchStartAngle, 
                         dbo.r_part_reinsketch.sketchEndAngle, dbo.r_part_reinsketch.sketchStartLength, dbo.r_part_reinsketch.sketchEndLength, dbo.r_part_reinpoints.onArc, dbo.r_part_reinsketch.partNote, dbo.r_part_reinpoints.rpID, 
                         dbo.r_part_reinpoints.x, dbo.r_part_reinpoints.y, dbo.r_part_reinpoints.z
FROM            dbo.r_part_reinsketch RIGHT OUTER JOIN
                         dbo.r_part_reinpoints RIGHT OUTER JOIN
                         dbo.part ON dbo.r_part_reinpoints.partID = dbo.part.partID ON dbo.r_part_reinsketch.partID = dbo.part.partID LEFT OUTER JOIN
                         dbo.partdef ON dbo.part.partdefID = dbo.partdef.partdefID LEFT OUTER JOIN
                         dbo.r_standard_posdef INNER JOIN
                         dbo.sortament ON dbo.r_standard_posdef.relID = dbo.sortament.stdposdefID RIGHT OUTER JOIN
                         dbo.position LEFT OUTER JOIN
                         dbo.r_rein_property ON dbo.position.srtmID = dbo.r_rein_property.srtmID ON dbo.sortament.srtmID = dbo.position.srtmID LEFT OUTER JOIN
                         dbo.r_sortament_property ON dbo.position.srtmID = dbo.r_sortament_property.srtmID LEFT OUTER JOIN
                         dbo.r_position_property ON dbo.position.posID = dbo.r_position_property.posID ON dbo.part.partID = dbo.position.partID
WHERE        (dbo.part.deleted = 0)
GO
