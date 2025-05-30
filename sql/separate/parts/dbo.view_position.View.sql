SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_position]
AS
SELECT     
dbo.i_catalog.catName,
dbo.part.partName, 
dbo.position.muID, 
dbo.position.posQuantity, 
dbo.position.posID, 
dbo.position.srtmID, 
dbo.i_catalog.catID, 
dbo.part.partID, 
dbo.position.mcID, 
dbo.position.posUnitMass, 
dbo.position.posCommonMass, 
dbo.position.numDigits, 
dbo.position.posNumber, 
dbo.position.posCMCalc, 
dbo.position.posUMCalc, 
dbo.part.deleted, 
dbo.part.partVersion, 
dbo.part.partSortNumber, 
dbo.part.partStatusID, 
dbo.position.posSketch, 
dbo.position.matID, 
dbo.r_position_property.volume, 
dbo.r_position_property.diamout, 
dbo.r_position_property.diaminn, 
dbo.r_position_property.width, 
dbo.r_position_property.thickness, 
dbo.r_position_property.segment, 
dbo.r_position_property.radiusout, 
dbo.r_position_property.radiusinn, 
dbo.r_position_property.radius, 
dbo.r_position_property.length, 
dbo.r_position_property.height, 
dbo.r_position_property.diameter, 
dbo.r_position_property.area, 
dbo.part.partdefID, 
dbo.part.catID AS Expr1, 
dbo.part.typeID, 
dbo.position.posBarLength, 
dbo.r_position_property.lenmin, 
dbo.r_position_property.lenmax, 
dbo.r_position_property.lenmid, 
dbo.posdef.masscalcID AS mcIDpd, 
dbo.r_standard_posdef.posdefID

FROM         dbo.part

INNER JOIN                      dbo.position ON dbo.part.partID = dbo.position.partID 
INNER JOIN                      dbo.sortament ON dbo.position.srtmID = dbo.sortament.srtmID 
INNER JOIN                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
INNER JOIN                      dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID 
LEFT OUTER JOIN                 dbo.r_position_property ON dbo.position.posID = dbo.r_position_property.posID 
LEFT OUTER JOIN                 dbo.i_catalog ON dbo.part.catID = dbo.i_catalog.catID
GO
