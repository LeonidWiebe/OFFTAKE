SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_FH1_Opening_Attributes]
AS
SELECT  
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
[dbo].[i_Opening].[PartCode]  AS '~Name',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],

[dbo].elements.pMaxX - [dbo].elements.pMinX  AS [dX],
[dbo].elements.pMaxY - [dbo].elements.pMinY  AS [dY],
[dbo].elements.pMaxZ - [dbo].elements.pMinZ  AS [dZ],

doc.o_filename AS o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_Opening ON dbo.elements.simID = dbo.i_Opening.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid













GO
