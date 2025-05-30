SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_cat_2_xx]
AS
SELECT     TOP (100) PERCENT dbo.view_position.catName, dbo.view_position.posdefName, dbo.view_position.srtmName, dbo.view_position.stdTypeName, 
                      dbo.view_position.stdNumber, dbo.view_position.muID, dbo.view_position.posQuantity, dbo.view_position.posID, dbo.view_position.srtmID, 
                      dbo.view_position.mcName, dbo.view_position.catID, dbo.view_position.partdefName, dbo.view_position.mcIDdef, dbo.view_position.mcTable, 
                      dbo.view_position.mcID, dbo.view_position.calcID, dbo.view_position.matID, dbo.view_position.matName, dbo.view_position.matStID, 
                      dbo.view_position.matStName, dbo.view_position.matStNumber, dbo.view_position.posUnitMass, dbo.view_position.posCommonMass, 
                      dbo.view_position.stdID, dbo.view_position.posdefID, dbo.view_position.numDigits, dbo.view_position.posNumber, dbo.view_position.posCMCalc, 
                      dbo.view_position.posUMCalc, dbo.view_position.deleted, dbo.view_position.partVersion, dbo.view_position.partSortNumber, 
                      dbo.view_position.partStatusID, dbo.view_position.diameter, dbo.view_spec_cat.catlistID, dbo.view_spec_cat.partdefNameMulti, 
                      dbo.view_spec_cat.partName, dbo.view_spec_cat.partDescr, dbo.view_spec_cat.partSheet, dbo.view_spec_cat.partMainPosEP, 
                      dbo.view_spec_cat.partQty, dbo.view_spec_cat.mass, dbo.view_spec_cat.partSortID, dbo.view_spec_cat.partID, dbo.view_position.posSketch, 
                      dbo.view_spec_cat.partdefID
FROM         dbo.view_position RIGHT OUTER JOIN
                      dbo.view_spec_cat ON dbo.view_position.partID = dbo.view_spec_cat.partID
WHERE     (dbo.view_position.posNumber = 1)
GO
