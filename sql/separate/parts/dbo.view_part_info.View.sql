SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_part_info]
AS
SELECT     dbo.part.partID, dbo.position.posNumber, dbo.posdef.posdefName, dbo.sortament.srtmName, dbo.view_standard.stdFullNumber, 
                      dbo.view_r_material_standard.matName, dbo.view_r_material_standard.stdFullNumber AS matStdNumber, dbo.position.posQuantity, 
                      dbo.position.posUnitMass, dbo.position.posCommonMass, dbo.isPartRun(dbo.part.partID) AS isRunMet, dbo.r_position_property.diameter, 
                      dbo.r_position_property.length, dbo.r_position_property.width, dbo.r_position_property.thickness, dbo.r_sortament_property.diameter AS Expr1, 
                      dbo.r_sortament_property.width AS Expr2, dbo.r_sortament_property.thickness AS Expr3
FROM         dbo.part INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID INNER JOIN
                      dbo.sortament ON dbo.position.srtmID = dbo.sortament.srtmID INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID INNER JOIN
                      dbo.view_standard ON dbo.r_standard_posdef.stdID = dbo.view_standard.stdID LEFT OUTER JOIN
                      dbo.r_sortament_property ON dbo.sortament.srtmID = dbo.r_sortament_property.srtmID LEFT OUTER JOIN
                      dbo.r_position_property ON dbo.position.posID = dbo.r_position_property.posID LEFT OUTER JOIN
                      dbo.view_r_material_standard ON dbo.position.matID = dbo.view_r_material_standard.matID

GO
