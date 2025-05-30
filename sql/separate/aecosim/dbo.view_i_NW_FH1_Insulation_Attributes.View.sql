SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_NW_FH1_Insulation_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.elemOldID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Name],
--dbo.i_InsulationAttributes.Type AS '~Type (brand)',
dbo.i_InsulationAttributes.ThermalConductivity AS '~Coefficient of thermal conductivity',

CASE
	when dbo.elements.cattype='InsulationWalls' and dbo.i_Wall.Width is not null then cast(  cast( round(i_Wall.Width * 0.01,0,0) AS bigint) AS varchar)
	when dbo.elements.cattype='InsulationSlabs' and dbo.i_Slab.Thickness is not null then cast( cast( round(dbo.i_Slab.Thickness * 0.01,0,0) as bigint) AS varchar)
End AS '~Insulation thickness',


doc.o_filename


FROM         dbo.elements 
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
LEFT JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
LEFT OUTER JOIN dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID
LEFT JOIN   dbo.i_InsulationAttributes ON dbo.elements.simID = dbo.i_InsulationAttributes.simID

GO
