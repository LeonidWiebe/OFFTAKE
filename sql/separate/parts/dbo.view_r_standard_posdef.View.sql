SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_standard_posdef]
AS
SELECT     dbo.r_standard_posdef.relID, dbo.posdef.posdefName, dbo.standard.stdName, dbo.standard.stdNumber, dbo.r_standard_posdef.posdefID, 
                      dbo.r_standard_posdef.stdID, dbo.standardtype.stdTypeName, 
                      LTRIM(REPLACE(dbo.standardtype.stdTypeName + dbo.standardtype.stdTypeDevision + dbo.standard.stdNumber, '_', ' ')) AS stdFullNumber, 
                      dbo.standard.stdUsing, dbo.r_standard_posdef.mcID, dbo.r_standard_posdef.using
FROM         dbo.standardtype RIGHT OUTER JOIN
                      dbo.standard ON dbo.standardtype.stdTypeID = dbo.standard.stdTypeID RIGHT OUTER JOIN
                      dbo.r_standard_posdef ON dbo.standard.stdID = dbo.r_standard_posdef.stdID LEFT OUTER JOIN
                      dbo.posdef ON dbo.r_standard_posdef.posdefID = dbo.posdef.posdefID
GO
