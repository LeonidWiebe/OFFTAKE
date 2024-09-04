SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_FH1_EmbPart_Wise_Cat]
AS
SELECT 
		parts.dbo.part.partName, 
      COUNT(DISTINCT(parts.dbo.part.catID)) AS 'catID'
  FROM [parts].[dbo].[part] 
  Where (parts.dbo.part.catID in (Select catID From aecosim.dbo.view_i_FH1_EmbPart_Wise_Offtake))
 --Where parts.dbo.part.catID ='19466'
Group BY [partName]
	




GO
