SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_strap]
 AS
SELECT     strapWidth AS 'Ширина', strapLength AS 'Длина', strapID AS 'mslink'
FROM         dbo.ms_strap


GO
