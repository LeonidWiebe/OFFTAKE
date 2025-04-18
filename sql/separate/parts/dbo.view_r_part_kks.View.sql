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
