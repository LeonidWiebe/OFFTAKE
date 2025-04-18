SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_LYG_Space_Dups]
AS
SELECT     

dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.elements.elemguid, 
dbo.i_Space.Doc2_ID,
dbo.i_Space.number AS kks, 
dbo.i_Space.label2 AS [name rus], 
dbo.i_Space.label AS [name eng], 
dbo.elements.dtID, 

dd.project_name, 
dd.deleted,
dd.old_file_name as file_path,

(select count(*) from view_i_LYG_Space a where a.kks_from_table = dbo.i_Space.number and a.deleted=0) as cnt

FROM         dbo.elements 

INNER JOIN dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id

/*

SELECT  *
  FROM [aecosim].[dbo].[view_i_LYG_Space_Dups] where  cnt>1 order by kks,pwdocid

*/






GO
