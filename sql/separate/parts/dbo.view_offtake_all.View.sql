SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_offtake_all]
AS
SELECT     [catlistID],[mass],[qty],[partdefID],[srtmID],[matID],[objID]
FROM         dbo.view_offtake_part
WHERE     dbo.view_offtake_part.objID = 1
UNION ALL
SELECT      [catlistID],[mass],[qty],[partdefID],[srtmID],[matID],[objID]
FROM         dbo.view_offtake_cat
WHERE     dbo.view_offtake_cat.objID = 7
UNION ALL
SELECT     [catlistID],[mass],[qty],[partdefID],[srtmID],[matID],[objID]
FROM         dbo.view_offtake_part_cl
WHERE     dbo.view_offtake_part_cl.objID = 14
UNION ALL
SELECT      [catlistID],[mass],[qty],[partdefID],[srtmID],[matID],[objID]
FROM         dbo.view_offtake_cat_cl
WHERE     dbo.view_offtake_cat_cl.objID = 14
GO
