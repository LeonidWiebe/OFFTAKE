SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


















CREATE VIEW [dbo].[view_i_NW_RoomEmpt]
AS
SELECT   
  
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.i_Space.number AS 'KKS',
	--doc.o_projguid as '~Projgid',
	dd.o_projectno as '~Projno',
	proj.o_projectname as '~Projname',
	proj.o_parentno as '~Parentno',
	dd.project_name,
	dd.bldName


FROM		dbo.elements 
inner JOIN	dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID
INNER JOIN	[PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
--INNER JOIN	[PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN	[PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_proj] as proj on dd.o_projectno = proj.o_projectno
WHERE i_Space.number not like '[0-9][0-9][A-Z][A-Z][A-Z][0-9][0-9][R][0-9][0-9][0-9]'





























GO
