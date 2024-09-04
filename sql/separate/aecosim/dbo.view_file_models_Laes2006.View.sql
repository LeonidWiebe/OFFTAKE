SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_file_models_Laes2006]
AS
SELECT        

m.serverID, 
m.prjName, 
m.pwdocID, 
d.file_path,
m.modID, 
m.modName,
m.uors_min,
m.uors_max

FROM            dbo.view_file_models m 

INNER JOIN                         dbo.pw_docs d ON m.pwdocID = d.pwdocID 

where m.prjName='Laes2006'



GO
