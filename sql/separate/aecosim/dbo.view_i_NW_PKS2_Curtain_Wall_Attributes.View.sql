SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[view_i_NW_PKS2_Curtain_Wall_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Name],
round(dbo.i_Dimensions.CWWidth * 1e-2, 0,2) AS '~Width', 
round(dbo.i_Dimensions.CWHeight * 1e-2, 0,2) AS '~Hight',
dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS '~Installation level',

doc.o_filename


FROM         dbo.elements 
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Left JOIN  dbo.i_Dimensions ON dbo.elements.simID = dbo.i_Dimensions.simID



















GO
