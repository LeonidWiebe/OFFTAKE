SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_role]
AS
SELECT     dbo.i_group.groupID, dbo.i_group.groupName, dbo.i_rule.ruleCreate, dbo.i_rule.ruleModify, dbo.i_rule.ruleMove, dbo.i_rule.ruleDelete, 
                      dbo.object.objID, dbo.object.objName, dbo.object.objDescription
FROM         dbo.i_group RIGHT OUTER JOIN
                      dbo.i_rule ON dbo.i_group.groupID = dbo.i_rule.groupID LEFT OUTER JOIN
                      dbo.object ON dbo.i_rule.objID = dbo.object.objID
GO
