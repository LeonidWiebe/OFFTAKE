SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_pdset_partdef]
AS
SELECT     dbo.partdef.partdefName, dbo.r_pdset_partdef.relID, dbo.r_pdset_partdef.partdefID, dbo.r_pdset_partdef.pdsID, dbo.r_pdset_partdef.relNameAlt, 
                      dbo.partdef.partdefNameMulti, dbo.partdef.partdefUsePositions, dbo.partdef.parentID, dbo.partdef.partdefSort, dbo.partdef.kksDiv
FROM         dbo.r_pdset_partdef INNER JOIN
                      dbo.partdef ON dbo.r_pdset_partdef.partdefID = dbo.partdef.partdefID
GO
