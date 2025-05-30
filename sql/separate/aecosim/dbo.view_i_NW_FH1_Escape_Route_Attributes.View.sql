SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








CREATE VIEW [dbo].[view_i_NW_FH1_Escape_route_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Name],
--dbo.i_StructuralFramingCommon.sectionname  AS '~Secton (HxW), mm',
[dbo].[i_ESC-ROUT].[ESC_Length]  AS '~Length',
SUBSTRING (LOWER(dbo.i_StructuralFramingCommon.sectionname),(CHARINDEX ('x',LOWER(dbo.i_StructuralFramingCommon.sectionname))+1),6) AS '~Width',
SUBSTRING (LOWER(dbo.i_StructuralFramingCommon.sectionname),0, CHARINDEX ('x',LOWER(dbo.i_StructuralFramingCommon.sectionname))) AS '~Height',


doc.o_filename


FROM         dbo.elements 
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN dbo.i_StructuralFramingCommon ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
INNER JOIN dbo.i_StructuralQuantities ON dbo.elements.simID = dbo.i_StructuralQuantities.simID
LEFT JOIN [dbo].[i_ESC-ROUT] ON dbo.elements.simID = [dbo].[i_ESC-ROUT].[simID]
WHERE dbo.elements.cattype = 'ESC-ROUT'



















GO
