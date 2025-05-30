SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE VIEW [dbo].[old_view_i_NW_PKS2_Layers]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 
	
'Layer' AS '~Name',
CASE 
  WHEN dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) In ('Concrete Wall', 'Concrete Slab', 'Concrete Beam', 'Concrete Column') THEN 'Reinforced Concrete'

END AS [~Material],
dbo.i_StructProp.FC AS '~Fire Class',

dbo.getLaerThiknes(dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem), round(dbo.i_Wall.Width * 1e-2, 0,2), round(dbo.i_Slab.Thickness * 1e-2, 0,2),'-')
 AS '~Thickness',
 
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_ConcreteExposure ON dbo.elements.simID = dbo.i_ConcreteExposure.simID
INNER JOIN   dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
INNER JOIN   dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID
LEFT JOIN   dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID
LEFT JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid






















GO
