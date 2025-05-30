SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_sortament]
AS
SELECT     TOP (100) PERCENT dbo.sortament.srtmID, dbo.posdef.posdefID, dbo.posdef.posdefName, dbo.sortament.srtmName, dbo.sortament.srtmUsing, 
                      dbo.standard.stdID, dbo.standardtype.stdTypeName, dbo.standard.stdNumber, dbo.standard.stdName, dbo.sortament.stdposdefID
FROM         dbo.standardtype RIGHT OUTER JOIN
                      dbo.posdef INNER JOIN
                      dbo.r_standard_posdef ON dbo.posdef.posdefID = dbo.r_standard_posdef.posdefID INNER JOIN
                      dbo.standard ON dbo.r_standard_posdef.stdID = dbo.standard.stdID ON dbo.standardtype.stdTypeID = dbo.standard.stdTypeID RIGHT OUTER JOIN
                      dbo.sortament ON dbo.r_standard_posdef.relID = dbo.sortament.stdposdefID
GO
