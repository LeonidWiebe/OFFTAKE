SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_clist_callback_all]
AS
SELECT     *
FROM         dbo.view_clist_callback_cat
UNION
SELECT     *
FROM         dbo.view_clist_callback_part

GO
