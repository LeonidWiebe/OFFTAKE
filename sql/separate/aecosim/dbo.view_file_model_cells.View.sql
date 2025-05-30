SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_file_model_cells]
AS
SELECT        

d.serverID, 
d.prjName as prjNameID, 
d.catID,
dbo.file_models.pwdocID, 
dbo.file_models.modID, 
dbo.file_models.modName as [Изделие],
(select count(*) from dbo.elements where dbo.elements.pwdocid = dbo.file_models.pwdocID and dbo.elements.modID = dbo.file_models.modID) as [Элементов]

FROM            dbo.file_models 

INNER JOIN                         dbo.pw_docs d ON dbo.file_models.pwdocID = d.pwdocID 

where dbo.file_models.modCell = 1

--group by 
--dbo.pw_docs.serverID, 
--dbo.pw_docs.prjName, 
--dbo.file_models.pwdocID, 
--dbo.file_models.modID, 
--dbo.file_models.modName


GO
