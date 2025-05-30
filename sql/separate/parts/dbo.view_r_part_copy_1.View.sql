SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_copy_1]
AS
SELECT     dbo.part.partID, dbo.part.catID, dbo.part.partName, dbo.part.parentID, dbo.part.deleted, dbo.part.partDescr, dbo.part.partVersion, dbo.part.partIDold, 
                      dbo.part.catIDold, dbo.part.partSheet, dbo.part.partSortNumber, dbo.part.partMainPosEP, dbo.part.partStatusID, dbo.part.usrID, dbo.position.posID, 
                      dbo.position.srtmID, dbo.position.muID, dbo.position.posQuantity, dbo.position.matID, dbo.position.posUnitMass, dbo.position.posCommonMass, 
                      dbo.position.mcID, dbo.position.numDigits, dbo.position.posNumber, dbo.position.posIDold, dbo.position.posUMCalc, dbo.position.posCMCalc, 
                      dbo.r_position_property.area, dbo.r_position_property.diameter, dbo.r_position_property.height, dbo.r_position_property.length, 
                      dbo.r_position_property.radius, dbo.r_position_property.radiusinn, dbo.r_position_property.radiusout, dbo.r_position_property.segment, 
                      dbo.r_position_property.thickness, dbo.r_position_property.width, dbo.r_position_property.diaminn, dbo.r_position_property.diamout, 
                      dbo.r_position_property.volume, dbo.position.posSketch, dbo.part.partRoundShift, dbo.part.partRoundSaved, dbo.part.partdefID, dbo.part.typeID, 
                      dbo.position.posBarLength, dbo.part.dsPartListID, dbo.part.dsDrawingsID, dbo.r_position_property.lenmin, dbo.r_position_property.lenmax, 
                      dbo.r_position_property.lenmid, dbo.part.partMass, dbo.position.posName
FROM         dbo.position INNER JOIN
                      dbo.part ON dbo.position.partID = dbo.part.partIDold LEFT OUTER JOIN
                      dbo.r_position_property ON dbo.position.posID = dbo.r_position_property.posID

GO
