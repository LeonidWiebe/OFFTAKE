SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_test5]
AS
  SELECT [pwdocID],[cattype] 
  from [aecosim].[dbo].[elements] 
  where [cattype]='Space'
  
GO
