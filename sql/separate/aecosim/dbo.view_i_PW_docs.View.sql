SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/*


INSERT INTO [dbo].[pw_docs] 
(pwdocID, serverID, file_path, deleted, bldID, prjName)
SELECT 
id,2,old_file_name,0,bldID,project_name   
from [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] where deleted=0 and project_name in ('Tianwan','Xudapu','el-dabaa')
and id not in (select pwdocID from pw_docs)
; 

SELECT [pwdocID]
      ,[serverID]
      ,[file_path]
      ,[deleted]
      ,[bldID]
      ,[prjName]
  FROM [aecosim].[dbo].[pw_docs]

SELECT  [ID]
      ,[o_docguid]
      ,[o_storname]
      ,[o_path]
      ,[folderName]
      ,[o_projectcode]
      ,[o_itemname]
      ,[o_original]
      ,[file_path]
      ,[deleted]
      ,[project_name]
      ,[o_projectno]
      ,[o_filename]
      ,[bldID]
      ,[bldName]
      ,[counter]
      ,[old_file_name]
  FROM [PW_AEP].[dbo].[view_docdata_all]

*/





CREATE VIEW [dbo].[view_i_PW_docs]
AS
SELECT     

dd.ID as pwdocID, 
dd.o_projectcode, 
dd.old_file_name as o_filename,
dd.o_original,
dd.deleted

FROM   [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] as dd




GO
