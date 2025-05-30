SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[view_i_PW_elem]
AS
SELECT     

dbo.elements.*, 
dd.bldName,
dd.project_name,
dd.old_file_name as file_path,
dd.o_original

FROM         dbo.elements 

INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
 where dd.deleted=0

union

SELECT     

dbo.elements.*, 
dd.bldName,
dd.project_name,
dd.old_file_name as file_path,
dd.o_original

FROM         dbo.elements 

INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
 where dd.deleted=0

GO
