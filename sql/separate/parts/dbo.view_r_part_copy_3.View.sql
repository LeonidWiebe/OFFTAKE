SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_copy_3]
AS
SELECT     dbo.r_part_reinpoints.posID, dbo.r_part_reinpoints.x, dbo.r_part_reinpoints.y, dbo.r_part_reinpoints.z, dbo.r_part_reinpoints.xd, 
                      dbo.r_part_reinpoints.yd, dbo.r_part_reinpoints.zd, dbo.r_part_reinpoints.isMain, dbo.r_part_reinpoints.isOk, dbo.r_part_reinpoints.xs, 
                      dbo.r_part_reinpoints.ys, dbo.r_part_reinpoints.zs, dbo.r_part_reinpoints.isSketchOk, dbo.r_part_reinpoints.xa, dbo.r_part_reinpoints.ya, 
                      dbo.r_part_reinpoints.za, dbo.r_part_reinpoints.isCont, dbo.part.partID, dbo.part.partName, dbo.part.parentID, dbo.part.catID, dbo.part.partdefID, 
                      dbo.part.typeID, dbo.part.deleted, dbo.part.partDescr, dbo.part.partVersion, dbo.part.partIDold, dbo.part.catIDold, dbo.part.partSheet, 
                      dbo.part.partSortNumber, dbo.part.partMass, dbo.part.partMainPosEP, dbo.part.partStatusID, dbo.part.usrID, dbo.part.partRoundShift, 
                      dbo.part.partRoundSaved, dbo.part.dsPartListID, dbo.part.dsDrawingsID
FROM         dbo.part INNER JOIN
                      dbo.r_part_reinpoints ON dbo.part.partIDold = dbo.r_part_reinpoints.partID

GO
