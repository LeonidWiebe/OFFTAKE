SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_SH12_Opening_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
--dbo.i_WindowProperties.KKS AS '~KKS door',


 round(dbo.i_Dimensions.width * 1e-2, 0,2) AS '~Width', 
 round(dbo.i_Dimensions.height * 1e-2, 0,2) AS '~Height',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename


FROM         dbo.elements 

INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
inner JOIN dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID
















GO
