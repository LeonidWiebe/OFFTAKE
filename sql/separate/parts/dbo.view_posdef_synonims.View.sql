SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_posdef_synonims]
 AS
SELECT     dbo.posdef.posdefID, dbo.posdef.posdefName, dbo.posdef_synonims.posdefName AS posdefSyn, dbo.posdef.masscalcID, 
                      dbo.posdef.posdefDefaultQty
FROM         dbo.posdef INNER JOIN
dbo.posdef_synonims ON dbo.posdef.posdefID = dbo.posdef_synonims.posdefID


GO
