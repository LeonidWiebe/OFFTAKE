SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_sp_relations]
AS
SELECT     standardSrc.stdNumber AS src, dbo.standard.stdNumber AS dst
FROM         dbo.standard INNER JOIN
                      dbo.r_standard_posdef INNER JOIN
                      dbo.r_sp_relations ON dbo.r_standard_posdef.relID = dbo.r_sp_relations.spSrcID INNER JOIN
                      dbo.r_standard_posdef AS r_standard_posdef_1 ON dbo.r_sp_relations.spDstID = r_standard_posdef_1.relID INNER JOIN
                      dbo.standard AS standardSrc ON dbo.r_standard_posdef.stdID = standardSrc.stdID ON dbo.standard.stdID = r_standard_posdef_1.stdID
GO
