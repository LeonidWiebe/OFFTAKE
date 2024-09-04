SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_opening]
 AS
SELECT     RTRIM(LTRIM(STR(openingWidth)))+'x'+RTRIM(LTRIM(STR(openingHeight))) AS 'openingName', openingWidth, openingHeight, 
                      openingID AS mslink
FROM         dbo.ms_opening


GO
