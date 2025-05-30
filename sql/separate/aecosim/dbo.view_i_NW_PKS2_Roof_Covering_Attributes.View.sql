SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











CREATE VIEW [dbo].[view_i_NW_PKS2_Roof_Covering_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
round(dbo.i_Slab.Thickness * 1e-2, 0,0) AS '~Total Thickness',
--dbo.getTrueArea2(dbo.elements.simID, 0, 2)  AS '~Площадь, м2',
--dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Общий объем, м3',
dbo.i_Layers.L1 AS '~Material of layer 1',
dbo.i_Layers.T1 AS '~Thickness of layer 1',
dbo.i_Layers.L2 AS '~Material of layer 2',
dbo.i_Layers.T2 AS '~Thickness of layer 2',
dbo.i_Layers.L3 AS '~Material of layer 3',
dbo.i_Layers.T3 AS '~Thickness of layer 3',
dbo.i_Layers.L4 AS '~Material of layer 4',
dbo.i_Layers.T4 AS '~Thickness of layer 4',
dbo.i_Layers.L5 AS '~Material of layer 5',
dbo.i_Layers.T5 AS '~Thickness of layer 5',
dbo.i_Layers.L6 AS '~Material of layer 6',
dbo.i_Layers.T6 AS '~Thickness of layer 6',
dbo.i_Layers.L7 AS '~Material of layer 7',
dbo.i_Layers.T7 AS '~Thickness of layer 7',
dbo.i_Layers.L8 AS '~Material of layer 8',
dbo.i_Layers.T8 AS '~Thickness of layer 8',
dbo.i_Layers.L8 AS '~Material of layer 9',
dbo.i_Layers.T8 AS '~Thickness of layer 9',
dbo.i_Layers.L8 AS '~Material of layer 10',
dbo.i_Layers.T8 AS '~Thickness of layer 10',
dbo.i_Layers.L8 AS '~Material of layer 11',
dbo.i_Layers.T8 AS '~Thickness of layer 11',
dbo.i_Layers.L8 AS '~Material of layer 12',
dbo.i_Layers.T8 AS '~Thickness of layer 12',	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],

doc.o_filename


FROM         dbo.elements 
INNER JOIN  dbo.i_Layers ON dbo.elements.simID = dbo.i_Layers.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN   dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID
























GO
