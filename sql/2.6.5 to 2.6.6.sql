
use parts

DROP VIEW [dbo].[view_r_part_kks]
GO
DROP VIEW [dbo].[view_r_part_kks_bld]
GO
DROP VIEW [dbo].[view_r_part_kks_blk]
GO

ALTER TABLE [dbo].[whatsnew] ADD [wnMajor] [bigint] NOT NULL CONSTRAINT [DF_whatsnew_wnMajor]  DEFAULT ((2))
GO
ALTER TABLE [dbo].[whatsnew] ADD [wnMinor] [bigint] NOT NULL CONSTRAINT [DF_whatsnew_wnMinor]  DEFAULT ((0))
GO
ALTER TABLE [dbo].[whatsnew] ADD [wnRev] [bigint] NOT NULL CONSTRAINT [DF_whatsnew_wnRev]  DEFAULT ((0))
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO

SET IDENTITY_INSERT [dbo].[whatsnew] ON
INSERT [dbo].[whatsnew] ([wnID], [wnDescr], [wnDate], [wnVers], [wnMajor], [wnMinor], [wnRev]) VALUES (59, N'Обновление для работы с БД AECOsim', CAST(0x0000A79F00CD3CFB AS DateTime), N'2.6.1', 2, 6, 1)
INSERT [dbo].[whatsnew] ([wnID], [wnDescr], [wnDate], [wnVers], [wnMajor], [wnMinor], [wnRev]) VALUES (60, N'Обновление для работы с подопорными', CAST(0x0000A8CF00CD6552 AS DateTime), N'2.6.6', 2, 6, 6)
SET IDENTITY_INSERT [dbo].[whatsnew] OFF

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_kks_blk]
AS
SELECT     dbo.r_part_kks.kksID, dbo.r_part_kks.kksSys, dbo.r_part_kks.kksNum, dbo.r_part_kks.partID, dbo.r_part_kks.formrow, dbo.r_part_kks.formcol, i_block_1.blockID, 
                      i_block_1.blockNumber, i_block_1.projectID, dbo.part.partName, dbo.part.catID, dbo.partdef.kksDiv, dbo.part.deleted, dbo.i_catalog.deleted AS catdel
FROM         dbo.partdef INNER JOIN
                      dbo.r_part_kks INNER JOIN
                      dbo.part ON dbo.r_part_kks.partID = dbo.part.partID ON dbo.partdef.partdefID = dbo.part.partdefID INNER JOIN
                      dbo.i_catalog ON dbo.part.catID = dbo.i_catalog.catID LEFT OUTER JOIN
                      dbo.i_block AS i_block_1 INNER JOIN
                      dbo.r_object_catalog AS r_object_catalog_1 ON i_block_1.blockID = r_object_catalog_1.objectID ON dbo.part.catID = r_object_catalog_1.catalogID
WHERE     (r_object_catalog_1.objID = 9)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_kks_bld]
AS
SELECT     dbo.r_part_kks.kksID, dbo.r_part_kks.kksSys, dbo.r_part_kks.kksNum, dbo.r_part_kks.partID, dbo.r_part_kks.formrow, dbo.r_part_kks.formcol, i_block_1.blockID, 
                      i_block_1.blockNumber, i_block_1.projectID, dbo.part.partName, dbo.part.catID, dbo.partdef.kksDiv, dbo.part.deleted, dbo.i_catalog.deleted AS catdel
FROM         dbo.partdef INNER JOIN
                      dbo.r_part_kks INNER JOIN
                      dbo.part ON dbo.r_part_kks.partID = dbo.part.partID ON dbo.partdef.partdefID = dbo.part.partdefID INNER JOIN
                      dbo.i_catalog ON dbo.part.catID = dbo.i_catalog.catID LEFT OUTER JOIN
                      dbo.i_building LEFT OUTER JOIN
                      dbo.i_block AS i_block_1 ON dbo.i_building.objectID = i_block_1.blockID RIGHT OUTER JOIN
                      dbo.r_object_catalog AS r_object_catalog_1 ON dbo.i_building.bldID = r_object_catalog_1.objectID ON dbo.part.catID = r_object_catalog_1.catalogID
WHERE     (r_object_catalog_1.objID = 8) AND (dbo.i_building.objID = 9)
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_r_part_kks]
AS
SELECT  [kksID]
      ,[kksSys]
      ,[kksNum]
      ,[partID]
      ,[formrow]
      ,[formcol]
      ,[blockID]
      ,[blockNumber]
      ,[projectID]
      ,[partName]
      ,[catID]
      ,[kksDiv]
      ,[deleted]
      ,[catdel]
FROM         dbo.view_r_part_kks_bld
UNION
SELECT  [kksID]
      ,[kksSys]
      ,[kksNum]
      ,[partID]
      ,[formrow]
      ,[formcol]
      ,[blockID]
      ,[blockNumber]
      ,[projectID]
      ,[partName]
      ,[catID]
      ,[kksDiv]
      ,[deleted]
      ,[catdel]
FROM         dbo.view_r_part_kks_blk
GO
