SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_APP_Embedded_Part]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
	
dbo.i_EmbPart.PartCode AS 'Code',
dbo.i_EmbPart.CatalogName AS 'Name',
 
	dbo.elements.pCentX as X,
	dbo.elements.pCentY as Y,
	dbo.elements.pCentZ as Z,


doc.o_filename AS o_filename,
doc.o_projectno AS pwfolderID,
dd.project_name as proj


FROM         dbo.elements 
INNER JOIN   dbo.i_EmbPart ON dbo.elements.simID = dbo.i_EmbPart.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid



GO
