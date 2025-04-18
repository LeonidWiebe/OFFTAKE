SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_position]
AS

SELECT        

dbo.part.partID, 
dbo.part.catID, 
dbo.part.partName, 
dbo.part.parentID, 
dbo.part.deleted, 
dbo.part.partDescr, 
dbo.part.partVersion, 
dbo.part.partIDold, 
dbo.part.catIDold, 
dbo.part.partSheet, 
dbo.part.partSortNumber, 
dbo.part.partMainPosEP, 
dbo.part.partStatusID, 
dbo.part.usrID, 
dbo.position.posID, 
dbo.position.srtmID AS pos_srtmID, 
dbo.position.muID, 
dbo.position.posQuantity, 
dbo.position.matID, 
dbo.position.posUnitMass, 
(CASE WHEN dbo.position.srtmID < 0 THEN
(SELECT        SUM(posCommonMass) FROM position p WHERE p.partID = - dbo.position.srtmID) 
ELSE 0 
END) AS partMass, 
dbo.position.posCommonMass, 
dbo.position.mcID, 
dbo.position.numDigits, 
dbo.position.posNumber, 
dbo.position.posIDold, 
dbo.position.posUMCalc, 
dbo.position.posCMCalc, 
dbo.r_position_property.area AS pos_area, 
dbo.r_position_property.diameter AS pos_diameter, 
dbo.r_position_property.height AS pos_height, 
dbo.r_position_property.length AS pos_length, 
dbo.r_position_property.radius AS pos_radius, 
dbo.r_position_property.radiusinn AS pos_radiusinn, 
dbo.r_position_property.radiusout AS pos_radiusout, 
dbo.r_position_property.segment AS pos_segment, 
dbo.r_position_property.thickness AS pos_thickness, 
dbo.r_position_property.width AS pos_width, 
dbo.r_position_property.diaminn AS pos_diaminn, 
dbo.r_position_property.diamout AS pos_diamout, 
dbo.r_position_property.volume AS pos_volume, 
dbo.i_catalog.catName, parentpart.partName AS partNameOld, 
dbo.position.posSketch, dbo.part.partRoundShift, 
dbo.part.partRoundSaved, dbo.part.partdefID, 
dbo.part.typeID, 
dbo.position.posBarLength, 
dbo.part.dsPartListID, 
dbo.part.dsDrawingsID, 
dbo.r_position_property.lenmin, 
dbo.r_position_property.lenmax, 
dbo.r_position_property.lenmid, 
dbo.position.posName, 
dbo.r_position_property.chainx AS pos_chainx, 
dbo.r_position_property.chainy AS pos_chainy, 
dbo.r_position_property.ancbend AS pos_ancbend

FROM            dbo.position 

RIGHT OUTER JOIN   dbo.i_catalog 
INNER JOIN  dbo.part ON dbo.i_catalog.catID = dbo.part.catID 
LEFT OUTER JOIN  dbo.part AS parentpart ON dbo.part.partIDold = parentpart.partID ON dbo.position.partID = dbo.part.partID 
LEFT OUTER JOIN  dbo.r_position_property ON dbo.position.posID = dbo.r_position_property.posID



--SELECT        dbo.part.partID, dbo.part.catID, dbo.part.partName, dbo.part.parentID, dbo.part.deleted, dbo.part.partDescr, dbo.part.partVersion, dbo.part.partIDold, dbo.part.catIDold, dbo.part.partSheet, dbo.part.partSortNumber, 
--                         dbo.part.partMainPosEP, dbo.part.partStatusID, dbo.part.usrID, dbo.position.posID, dbo.position.srtmID AS pos_srtmID, dbo.position.muID, dbo.position.posQuantity, dbo.position.matID, dbo.position.posUnitMass, 
--                         (CASE WHEN dbo.position.srtmID < 0 THEN
--                             (SELECT        SUM(posCommonMass)
--                               FROM            position p
--                               WHERE        p.partID = - dbo.position.srtmID) ELSE 0 END) AS partMass, dbo.position.posCommonMass, dbo.position.mcID, dbo.position.numDigits, dbo.position.posNumber, dbo.position.posIDold, dbo.position.posUMCalc, 
--                         dbo.position.posCMCalc, dbo.r_position_property.area AS pos_area, dbo.r_position_property.diameter AS pos_diameter, dbo.r_position_property.height AS pos_height, dbo.r_position_property.length AS pos_length, 
--                         dbo.r_position_property.radius AS pos_radius, dbo.r_position_property.radiusinn AS pos_radiusinn, dbo.r_position_property.radiusout AS pos_radiusout, dbo.r_position_property.segment AS pos_segment, 
--                         dbo.r_position_property.thickness AS pos_thickness, dbo.r_position_property.width AS pos_width, dbo.r_position_property.diaminn AS pos_diaminn, dbo.r_position_property.diamout AS pos_diamout, 
--                         dbo.r_position_property.volume AS pos_volume, dbo.i_catalog.catName, parentpart.partName AS partNameOld, dbo.position.posSketch, dbo.part.partRoundShift, dbo.part.partRoundSaved, dbo.part.partdefID, dbo.part.typeID, 
--                         dbo.position.posBarLength, dbo.part.dsPartListID, dbo.part.dsDrawingsID, dbo.r_position_property.lenmin, dbo.r_position_property.lenmax, dbo.r_position_property.lenmid, dbo.position.posName, 
--                         dbo.r_position_property.chainx AS pos_chainx, dbo.r_position_property.chainy AS pos_chainy, dbo.r_position_property.ancbend AS pos_ancbend
--FROM            dbo.position RIGHT OUTER JOIN
--                         dbo.i_catalog INNER JOIN
--                         dbo.part ON dbo.i_catalog.catID = dbo.part.catID LEFT OUTER JOIN
--                         dbo.part AS parentpart ON dbo.part.partIDold = parentpart.partID ON dbo.position.partID = dbo.part.partID LEFT OUTER JOIN
--                         dbo.r_position_property ON dbo.position.posID = dbo.r_position_property.posID

GO
