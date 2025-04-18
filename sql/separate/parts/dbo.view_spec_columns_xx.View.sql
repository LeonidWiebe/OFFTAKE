SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_spec_columns_xx]
AS
SELECT     dbo.spec_config.scName, dbo.spec_config.scCapCell, dbo.spec_columns.scolWidth, dbo.spec_columns.scolNum
FROM         dbo.spec_config LEFT OUTER JOIN
                      dbo.spec_columns ON dbo.spec_config.scID = dbo.spec_columns.scID
GO
