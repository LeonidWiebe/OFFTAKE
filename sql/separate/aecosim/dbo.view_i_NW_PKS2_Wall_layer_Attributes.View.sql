SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[view_i_NW_PKS2_Wall_layer_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 

	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],

CASE
	WHEN dbo.elements.partdef = 'Fasade::Insulation' Then 'Insulation'
	WHEN dbo.elements.partdef = 'Fasade::Metal' Then 'Corrugated steel sheet'
	WHEN dbo.elements.partdef = 'Fasade::Concrete' Then 'Concrete panel'
	ELSE dbo.elements.partdef
END AS [~Name],
round((dbo.i_Wall.Width*dbo.elements.uors) * 1e-7, 0,0) AS '~Width',
--round((dbo.i_Wall.Height*dbo.elements.uors) * 1e-7, 0,0) AS '~Height, mm',
doc.o_filename


FROM         dbo.elements 
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
Left JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID























GO
