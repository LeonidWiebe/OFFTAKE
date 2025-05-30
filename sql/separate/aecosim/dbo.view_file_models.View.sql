SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_file_models]
AS
SELECT        

dbo.pw_docs.serverID, 
dbo.pw_docs.prjName, 
dbo.file_models.pwdocID, 
dbo.file_models.modID, 
dbo.file_models.modName,
max(dbo.elements.uors) as uors_max,
min(dbo.elements.uors) as uors_min

FROM            dbo.elements 

INNER JOIN                         dbo.pw_docs ON dbo.elements.pwdocID = dbo.pw_docs.pwdocID 
INNER JOIN                         dbo.file_models ON dbo.elements.modID = dbo.file_models.modID and dbo.elements.pwdocID =dbo.file_models.pwdocID

group by 
dbo.pw_docs.serverID, 
dbo.pw_docs.prjName, 
dbo.file_models.pwdocID, 
dbo.file_models.modID, 
dbo.file_models.modName


GO
