SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_partsys]
 AS
SELECT     mslink, partsysName
FROM         dbo.ms_partsys


GO
