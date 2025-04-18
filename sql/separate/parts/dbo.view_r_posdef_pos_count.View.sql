SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_posdef_pos_count]
AS
SELECT     TOP (100) PERCENT COUNT(dbo.position.posID) AS cnt, dbo.posdef.posdefID
FROM         dbo.r_standard_posdef AS r_standard_posdef_1 INNER JOIN
                      dbo.posdef ON r_standard_posdef_1.posdefID = dbo.posdef.posdefID INNER JOIN
                      dbo.sortament ON r_standard_posdef_1.relID = dbo.sortament.stdposdefID INNER JOIN
                      dbo.position ON dbo.sortament.srtmID = dbo.position.srtmID
GROUP BY dbo.posdef.posdefID

GO
