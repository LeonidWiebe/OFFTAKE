SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_FH1_PP_Technical_Means_Properties]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.i_PPTechnicalMeans.Name AS '~KKS code',
dbo.i_PPTechnicalMeans.AccesID AS '~Acces ID',
dbo.i_PPTechnicalMeans.PhysicalDetection AS '~Physical detection principle',
dbo.i_PPTechnicalMeans.SecurityZone AS '~Security zone',
dbo.i_PPTechnicalMeans.Description AS '~Description',


doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_PPTechnicalMeans ON dbo.elements.simID = dbo.i_PPTechnicalMeans.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
















GO
