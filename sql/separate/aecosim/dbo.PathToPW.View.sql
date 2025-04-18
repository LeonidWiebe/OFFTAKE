SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[PathToPW]
AS 
SELECT *
FROM
(SELECT     pw.o_projectno as 'Projno',
			pw.o_filename as 'File',
			pw.file_path  as 'Path',
			pw.bldName as 'Bld',
			pw.project_name as 'Prname',
			view_i_NW_Civil_Components.Object as 'Object'
FROM        dbo.view_i_NW_Civil_Components 
INNER JOIN	[PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] as pw ON dbo.view_i_NW_Civil_Components.pwdocID = pw.id
--Left Join dbo.[i_ESC-ROUT] on dbo.view_i_NW_Civil_Components.simID = dbo.[i_ESC-ROUT].simID
WHERE pw.deleted = 0 
--AND dbo.[i_ESC-ROUT].ESC_length is null or pw.deleted = 0 AND dbo.[i_ESC-ROUT].ESC_length =''
UNION 
SELECT 
			pwrk.o_projectno as 'Projno',
			pwrk.o_filename as 'File',
			pwrk.file_path  as 'Path',
			pwrk.bldName as 'Bld',
			pwrk.project_name as 'Prname',
			view_i_NW_Civil_Components.Object as 'Object'
FROM		dbo.view_i_NW_Civil_Components
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] as pwrk ON dbo.view_i_NW_Civil_Components.pwdocID = pwrk.id

) AS Result

WHERE Result.Object in ('ROOM') 

AND Result.Bld in ('10UKA')
AND Result.Prname = 'Hanhikivi'
--OR 
--Result.Prname = 'El-Dabaa'





















GO
