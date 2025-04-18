SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_posdef]
AS
SELECT     dbo.posdef.posdefID, dbo.masscalc.mcID, dbo.posdef.posdefName, dbo.masscalc.mcName, dbo.masscalc.mcDescription, dbo.masscalc.mcTable, 
                      dbo.posdef.posdefDefaultQty, dbo.posdef.posdefUsing, dbo.posdef.isRein
FROM         dbo.masscalc INNER JOIN
                      dbo.posdef ON dbo.masscalc.mcID = dbo.posdef.masscalcID
GO
