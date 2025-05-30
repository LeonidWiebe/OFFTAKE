SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_NW_PKS2_Insulation_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [~Name],
dbo.i_InsulationAttributes.Type AS '~Type',
--dbo.i_InsulationAttributes.ThermalConductivity AS 'Coefficient of thermal conductivity, W/mK',

CASE
	WHEN dbo.i_Wall.Width is NULL Then round((dbo.elements.pMaxZ - dbo.elements.pMinZ)* 1e-0, 0)
	Else round((dbo.i_Wall.Width*dbo.elements.uors) * 1e-7, 0,0)
End AS '~Thickness',


doc.o_filename


FROM         dbo.elements 
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
LEFT JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
LEFT JOIN   dbo.i_InsulationAttributes ON dbo.elements.simID = dbo.i_InsulationAttributes.simID



















GO
