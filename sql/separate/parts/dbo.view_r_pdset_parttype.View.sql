SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_pdset_parttype]
AS
SELECT     dbo.r_pdset_parttype.relID, dbo.r_pdset_parttype.ptID, dbo.r_pdset_parttype.pdsID, dbo.r_pdset_parttype.relNameAlt, dbo.parttype.typeName, dbo.parttype.specID, 
                      dbo.parttype.sortID
FROM         dbo.parttype INNER JOIN
                      dbo.r_pdset_parttype ON dbo.parttype.typeID = dbo.r_pdset_parttype.ptID
GO
