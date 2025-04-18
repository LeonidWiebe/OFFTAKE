SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[view_block]
 AS
SELECT    

i_block.[blockID]
,i_block.[blockNumber]
,i_block.[projectID]
,i_block.[deleted]
,i_block.[pwPrjName]
,i_project.[projectName]
,i_project.[projectPath]
--,i_project.[deleted]
,i_project.[typeID]
,i_project.[projectCode]
,i_project.[specID]
,i_project.[useRienFillet]
,i_project.[useMassDop]
,i_project.[useStdNumberAlt]
,i_project.projectDSTable

FROM   dbo.i_block      

LEFT OUTER JOIN dbo.i_project  ON dbo.i_project.projectID = dbo.i_block.projectID

where i_project.[deleted] = 0

GO
