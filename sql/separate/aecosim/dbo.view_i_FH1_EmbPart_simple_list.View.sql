SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_FH1_EmbPart_simple_list]
AS
SELECT 
      [catalogname]
      ,[partcode]
	  ,dd.project_name
	  ,dd.o_filename fname
FROM [aecosim].[dbo].elements e
  INNER JOIN [aecosim].[dbo].[view_i_EmbPart] ep on ep.simid=e.simid
  INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON ep.pwdocID = dd.id
  where project_name='Hanhikivi'
  --order by fname,partcode


GO
