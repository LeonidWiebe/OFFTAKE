SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_usr_2_xx]
AS
SELECT     TOP (100) PERCENT dbo.view_position.catName, dbo.view_position.posdefName, dbo.view_position.srtmName, dbo.view_position.stdTypeName, 
                      dbo.view_position.stdNumber, dbo.view_position.muID, dbo.view_position.posQuantity, dbo.view_position.posID, dbo.view_position.srtmID, 
                      dbo.view_position.mcName, dbo.view_position.catID, dbo.view_position.partdefName, dbo.view_position.mcIDdef, dbo.view_position.mcTable, 
                      dbo.view_position.mcID, dbo.view_position.calcID, dbo.view_position.matID, dbo.view_position.matName, dbo.view_position.matStID, 
                      dbo.view_position.matStName, dbo.view_position.matStNumber, dbo.view_position.posUnitMass, dbo.view_position.posCommonMass, 
                      dbo.view_position.stdID, dbo.view_position.posdefID, dbo.view_position.numDigits, dbo.view_position.posNumber, dbo.view_position.posCMCalc, 
                      dbo.view_position.posUMCalc, dbo.view_position.deleted, dbo.view_position.partVersion, dbo.view_position.partSortNumber, 
                      dbo.view_position.partStatusID, dbo.view_position.diameter, dbo.view_spec.partdefNameMulti, dbo.view_spec.partName, dbo.view_spec.partDescr, 
                      dbo.view_spec.partSheet, dbo.view_spec.partMainPosEP, dbo.view_spec.partQty, dbo.view_spec.mass, dbo.view_spec.partSortID, 
                      dbo.view_spec.partID, dbo.view_spec.usrID, dbo.view_position.posSketch, dbo.view_spec.partdefID
FROM         dbo.view_position RIGHT OUTER JOIN
                      dbo.view_spec ON dbo.view_position.partID = dbo.view_spec.partID
WHERE     (dbo.view_position.posNumber = 1)
GO
