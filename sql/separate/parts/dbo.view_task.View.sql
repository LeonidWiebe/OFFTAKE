SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_task]
 AS
SELECT     dbo.taskversion.versionID AS mslink, dbo.c_building.buildingCode, dbo.c_building.buildingName, dbo.task.taskName, dbo.tasktype.tasktypeName, 
                      dbo.taskversion.versionDate, dbo.taskversion.usrLogin
FROM         dbo.task INNER JOIN
dbo.c_building ON dbo.task.buildingID = dbo.c_building.buildingID INNER JOIN
dbo.tasktype ON dbo.task.taskType = dbo.tasktype.tasktypeID LEFT OUTER JOIN
dbo.taskversion ON dbo.task.taskID = dbo.taskversion.taskID


GO
