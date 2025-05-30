SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





Create VIEW [dbo].[old_view_i_NW_PKS2_Sfety_Classefication]
AS
SELECT 
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
dbo.i_StructProp.NSC AS '~Safety Class',
dbo.i_StructProp.SC AS '~Seismic Class',

dbo.getTypeElement(dbo.elements.cattype, 
dbo.elements.partdef, 
dbo.elements.catitem) AS [Object],
doc.o_filename

FROM         dbo.elements 
RIGHT OUTER JOIN   dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
RIGHT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
RIGHT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid





















GO
