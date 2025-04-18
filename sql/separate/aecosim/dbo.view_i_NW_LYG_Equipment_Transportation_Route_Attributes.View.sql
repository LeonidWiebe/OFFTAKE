SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_NW_LYG_Equipment_Transportation_Route_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.[i_ET-Route].ETCode AS [~Name],
--dbo.i_StructuralFramingCommon.sectionname  AS '~Secton (HxW), mm',
--dbo.i_StructuralQuantities.Length  AS '~Length',
SUBSTRING (LOWER(dbo.i_StructuralFramingCommon.sectionname),(CHARINDEX ('x',LOWER(dbo.i_StructuralFramingCommon.sectionname))+1),6) AS '~Width',
SUBSTRING (LOWER(dbo.i_StructuralFramingCommon.sectionname),0, CHARINDEX ('x',LOWER(dbo.i_StructuralFramingCommon.sectionname))) AS '~Height',
dbo.[i_ET-Route].NetWeight AS [~Сoncentrated wheel load],
doc.o_filename


FROM         dbo.elements 
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN dbo.i_StructuralFramingCommon ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
INNER JOIN dbo.i_StructuralQuantities ON dbo.elements.simID = dbo.i_StructuralQuantities.simID
INNER JOIN dbo.[i_ET-Route] ON dbo.elements.simID = dbo.[i_ET-Route].simID
WHERE dbo.elements.cattype = 'ET-ROUT' 






















GO
