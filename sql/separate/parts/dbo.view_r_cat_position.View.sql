SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_cat_position]
AS
SELECT     dbo.i_catalog.catID, dbo.i_catalog.catName, dbo.i_catalog.deleted, dbo.i_catalog.catTypeID, dbo.i_catalog.catlistID, dbo.i_catalog.forTesting, 
                      dbo.i_catalog.catUnif, dbo.i_catalog.catOpen, dbo.i_catalog.dsDrawingsID, dbo.i_catalog.dsPartListID, dbo.i_catalog.catStatus, dbo.i_catalog.dsLev, 
                      dbo.i_catalog.dsNum, dbo.catpos.posID, dbo.catpos.srtmID AS pos_srtmID, dbo.catpos.muID, dbo.catpos.posQuantity, dbo.catpos.matID, 
                      dbo.catpos.posUnitMass, dbo.catpos.posCommonMass, dbo.catpos.mcID, dbo.catpos.numDigits, dbo.catpos.posNumber, dbo.catpos.posUMCalc, 
                      dbo.catpos.posCMCalc, dbo.catpos.posSketch, dbo.catpos.posBarLength, dbo.r_catpos_property.area AS pos_area, 
                      dbo.r_catpos_property.diameter AS pos_diameter, dbo.r_catpos_property.height AS pos_height, dbo.r_catpos_property.length AS pos_length, 
                      dbo.r_catpos_property.radius AS pos_radius, dbo.r_catpos_property.radiusinn AS pos_radiusinn, dbo.r_catpos_property.radiusout AS pos_radiusout, 
                      dbo.r_catpos_property.segment AS pos_segment, dbo.r_catpos_property.thickness AS pos_thickness, dbo.r_catpos_property.width AS pos_width, 
                      dbo.r_catpos_property.diaminn AS pos_diaminn, dbo.r_catpos_property.diamout AS pos_diamout, dbo.r_catpos_property.volume AS pos_volume, 
                      dbo.r_catpos_property.lenmin AS pos_lenmin, dbo.r_catpos_property.lenmax AS pos_lenmax, dbo.r_catpos_property.lenmid AS pos_lenmid, 
                      dbo.r_catpos_property.catdef AS pos_catdef, dbo.r_catpos_property.glevel AS pos_glevel
FROM         dbo.r_catpos_property RIGHT OUTER JOIN
                      dbo.catpos ON dbo.r_catpos_property.posID = dbo.catpos.posID RIGHT OUTER JOIN
                      dbo.i_catalog ON dbo.catpos.partID = dbo.i_catalog.catID
GO
