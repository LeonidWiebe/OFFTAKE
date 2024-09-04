SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[view_i_NW_PartsEmpt]
AS
SELECT     
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.i_EmbPart.PartCode AS 'KKS',
	dd.o_projectno as '~Projno',
	proj.o_projectname as '~Projname',
	proj.o_parentno as '~Parentno',
	dd.project_name
	,dd.bldName



FROM		dbo.elements 
inner JOIN	dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID
INNER JOIN	[PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN	[PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_proj] as proj on dd.o_projectno = proj.o_projectno

WHERE
i_EmbPart.PartCode not like '[0-9][0-9][A-Z][A-Z][A-Z][0-9][0-9][R][0-9][0-9][0-9]' 









GO
