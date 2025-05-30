SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_pdset_posdef]
AS
SELECT        dbo.r_pdset_posdef.relID, dbo.r_pdset_posdef.pdsID, dbo.r_pdset_posdef.relNameAlt, dbo.posdef.posdefID, dbo.posdef.posdefName, dbo.posdef.posdefNameMulti, dbo.posdef.massCommon, dbo.posdef.sortNumber, 
                         dbo.posdef.posdefDrawSign, dbo.posdef.posdefDrawName, dbo.posdef.posdefDrawSymbol, dbo.posdef.posdefDrawSrtmPrefix, dbo.posdef.posdefNumber, dbo.posdef.posdefSP, dbo.posdef.masscalcID, 
                         dbo.posdef.posdefUsing, dbo.posdef.posdefDefaultQty, dbo.posdef.calcID, dbo.posdef.posdefIDGlobal, dbo.posdef.objID, dbo.posdef.isDraw3D, dbo.posdef.isRein, dbo.posdef.massLevel, dbo.posdef.posNum, 
                         dbo.posdef.pdIDtoCalc, dbo.pdset.pdsName, dbo.view_r_posdef_pos_count.cnt
FROM            dbo.pdset INNER JOIN
                         dbo.r_pdset_posdef ON dbo.pdset.pdsID = dbo.r_pdset_posdef.pdsID INNER JOIN
                         dbo.posdef ON dbo.r_pdset_posdef.posdefID = dbo.posdef.posdefID LEFT OUTER JOIN
                         dbo.view_r_posdef_pos_count ON dbo.posdef.posdefID = dbo.view_r_posdef_pos_count.posdefID
GO
