SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_project_block]
 AS
SELECT     dbo.i_project.projectID, dbo.i_project.projectName, dbo.i_project.projectPath, dbo.i_project.deleted, dbo.i_block.blockNumber, 
                      dbo.i_block.deleted AS blockDeleted, dbo.i_block.blockID
FROM         dbo.i_project LEFT OUTER JOIN
dbo.i_block ON dbo.i_project.projectID = dbo.i_block.projectID
WHERE     (dbo.i_block.deleted = 0 OR
dbo.i_block.deleted IS NULL) AND (dbo.i_project.deleted = 0)


GO
