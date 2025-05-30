SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_r_part_reinpoints]
AS
SELECT     dbo.r_part_reinpoints.rpID, dbo.r_part_reinpoints.partID, dbo.r_part_reinpoints.posID, dbo.r_part_reinpoints.x, dbo.r_part_reinpoints.y, 
                      dbo.r_part_reinpoints.z, dbo.r_part_reinpoints.xd, dbo.r_part_reinpoints.yd, dbo.r_part_reinpoints.zd, dbo.r_part_reinpoints.isMain, 
                      dbo.r_part_reinpoints.isOk, dbo.part.catID, dbo.position.srtmID, dbo.part.deleted, dbo.r_part_reinpoints.xa, dbo.r_part_reinpoints.ya, 
                      dbo.r_part_reinpoints.za
FROM         dbo.r_part_reinpoints INNER JOIN
                      dbo.part ON dbo.r_part_reinpoints.partID = dbo.part.partID INNER JOIN
                      dbo.position ON dbo.part.partID = dbo.position.partID
WHERE     (dbo.position.posNumber = 1)
GO
