SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_Space_doc_group_bkp]
AS
SELECT     
dbo.elements.pwdocID,
count(dbo.elements.cattype) as cnt,
dd.project_name as prjname,
dd.bldname as bldname,
dd.old_file_name as filepath
FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid

where dd.deleted = 0
group by pwdocID,dd.project_name,dd.bldname,dd.old_file_name



GO
