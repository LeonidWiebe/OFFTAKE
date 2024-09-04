SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_FH1_EmbPart_Wise_Offtake]
AS
SELECT [nnn]
      ,[buildingCode]
		,[catID]
      ,[deleted]
      ,[projectID]
      ,[n]
  FROM [parts].[dbo].[view_catpath]
  WHERE [projectID]=60 AND [deleted]=0 AND [n]in (2,8)



GO
