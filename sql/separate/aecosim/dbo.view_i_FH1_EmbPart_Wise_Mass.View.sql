SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_FH1_EmbPart_Wise_Mass]
AS
SELECT 
[partID], 
ROUND(SUM(posCommonMass),1) as 'posCommonMass'
FROM [parts].[dbo].[position] 
Group BY [partID]



GO
