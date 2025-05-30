SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_ms_srtm]
AS
SELECT     dbo.posdef.posdefName, dbo.sortament.srtmName, dbo.view_standard.stdFullNumber, dbo.view_standard.stdName, 
                      dbo.sortament.srtmID AS mslink
FROM         dbo.sortament INNER JOIN
                      dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID INNER JOIN
                      dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID INNER JOIN
                      dbo.view_standard ON dbo.r_standard_posdef.stdID = dbo.view_standard.stdID
GO
