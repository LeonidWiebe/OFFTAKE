SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_reinsketch]
AS
SELECT     dbo.part.catID, dbo.r_part_reinsketch.sketchID, dbo.r_part_reinsketch.partID, dbo.r_part_reinsketch.sketchStartType, 
                      dbo.r_part_reinsketch.sketchStartAngle, dbo.r_part_reinsketch.sketchStartLength, dbo.r_part_reinsketch.sketchEndType, 
                      dbo.r_part_reinsketch.sketchEndAngle, dbo.r_part_reinsketch.sketchEndLength
FROM         dbo.part INNER JOIN
                      dbo.r_part_reinsketch ON dbo.part.partID = dbo.r_part_reinsketch.partID
WHERE     (dbo.part.deleted = 0)

GO
