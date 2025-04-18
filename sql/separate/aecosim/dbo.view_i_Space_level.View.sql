SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_i_Space_level]
AS
SELECT     dbo.i_Space.simID, dbo.elements.pwdocID, LEFT(dbo.i_Space.number, 7) AS kkslevel
FROM         dbo.i_Space INNER JOIN
                      dbo.elements ON dbo.i_Space.simID = dbo.elements.simID
GO
