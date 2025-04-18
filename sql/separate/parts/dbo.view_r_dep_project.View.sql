SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_dep_project]
AS
SELECT     

p.projectName, 
dp.projectID, 
dp.depID, 
dp.projectPath, 
p.deleted, 
p.typeID, 
dp.readOnly, 
dep.depName AS dprtName, 
p.useMassDop

FROM         dbo.r_department_project dp

INNER JOIN dbo.i_project p ON dp.projectID = p.projectID 
INNER JOIN dbo.department dep ON dp.depID = dep.depID

GO
