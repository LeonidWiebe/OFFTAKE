SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_part_ms]
 AS
SELECT     partID AS mslink, partName
FROM         dbo.part


GO
