SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_SPF_Room]
AS
SELECT  * 

 from [FH1SPF]..[HNH_DATA].[DATAOBJ]
where 
objdefuid = 'RMAuthRoom'
and terminationdate = '9999/12/31-23:59:59:999'

GO
