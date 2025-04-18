SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_parts_first_positions]
AS
SELECT     dbo.part.partName, dbo.parttype.typeName, dbo.position.posNumber, dbo.posdef.posdefName, dbo.sortament.srtmName, dbo.part.partID
FROM         dbo.part INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID INNER JOIN
                      dbo.i_catalog ON dbo.part.catID = dbo.i_catalog.catID INNER JOIN
                      dbo.sortament ON dbo.position.srtmID = dbo.sortament.srtmID INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID INNER JOIN
                      dbo.parttype ON dbo.part.typeID = dbo.parttype.typeID
WHERE     (dbo.i_catalog.catID = 1) AND (dbo.position.posNumber = 1) AND (dbo.posdef.posdefID = 1) AND (dbo.part.partName LIKE 'M%')
GO
