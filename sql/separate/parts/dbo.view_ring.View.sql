SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE VIEW [dbo].[view_ring]
 AS
SELECT     ringWidth AS [Ширина], ringRadius AS [Радиус], ringRadius+ringWidth/2 AS [Внешний], ringRadius -ringWidth/2 AS [Внутренний], 
                      ringID AS mslink
FROM         dbo.ms_ring


GO
