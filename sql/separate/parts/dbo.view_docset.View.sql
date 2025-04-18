SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_docset]
AS
SELECT     dbo.docset.*, dbo.i_project.projectName, dbo.docsettype.dstName
FROM         dbo.docset LEFT OUTER JOIN
                      dbo.i_project ON dbo.docset.projectID = dbo.i_project.projectID LEFT OUTER JOIN
                      dbo.docsettype ON dbo.docset.dsTypeID = dbo.docsettype.dstID

GO
