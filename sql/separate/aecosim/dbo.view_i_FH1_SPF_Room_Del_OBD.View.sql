SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_FH1_SPF_Room_Del_OBD]
AS
SELECT    
SUBSTRING (SPF.OBJNAME,0,6) AS 'Building' 
,SUBSTRING (SPF.OBJNAME,0,8) AS 'Level' 
,SPF.OBJNAME
,SPF.LASTUPDATED
,SPF.CREATIONUSER
--,i_Space.number

from [FH1SPF]..[HNH_DATA].[DATAOBJ] AS SPF
LEFT JOIN aecosim.dbo.i_Space AS i_Space ON SPF.OBJNAME = i_Space.number COLLATE SQL_Latin1_General_CP1_CI_AS

Where objdefuid = 'RMAuthRoom' and terminationdate = '9999/12/31-23:59:59:999'
AND i_Space.number is Null 


GO
