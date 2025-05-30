SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_catpath]
AS
SELECT     nnn, buildingCode, catID, deleted, projectID, 1 AS n
FROM         dbo.view_catpath_p_b_u_c_c
UNION
SELECT     nnn, buildingCode, catID, deleted, projectID, 2 AS n
FROM         dbo.view_catpath_p_b_u_c_x
UNION
SELECT     nnn, buildingCode, catID, deleted, projectID, 3 AS n
FROM         dbo.view_catpath_p_b_x_c_c
UNION
SELECT     nnn, buildingCode, catID, deleted, projectID, 4 AS n
FROM         dbo.view_catpath_p_b_x_c_x
UNION
SELECT     nnn, buildingCode, catID, deleted, projectID, 5 AS n
FROM         dbo.view_catpath_p_x_u_c_c
UNION
SELECT     nnn, buildingCode, catID, deleted, projectID, 6 AS n
FROM         dbo.view_catpath_p_x_u_c_x
UNION
SELECT     nnn, buildingCode, catID, deleted, projectID, 7 AS n
FROM         dbo.view_catpath_p_x_x_c_c
UNION
SELECT     nnn, buildingCode, catID, deleted, projectID, 8 AS n
FROM         dbo.view_catpath_p_x_x_c_x
GO
