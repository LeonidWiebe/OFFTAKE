SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[view_i_NW_SH12_Multilayer_Panel_Properties]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 


round(dbo.i_Wall.Width * 1e-2, 0,0) AS '~Общая толщина, мм',
dbo.getTrueVertArea(dbo.elements.simID, 0, 2)  AS '~Площадь, м2',
dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Общий объем, м3',

dbo.i_Layers.L1 AS '~Материал слоя 1',
dbo.i_Layers.T1 AS '~Толщина слоя 1, мм',
dbo.i_Layers.L2 AS '~Материал слоя 2',
dbo.i_Layers.T2 AS '~Толщина слоя 2, мм',
dbo.i_Layers.L3 AS '~Материал слоя 3',
dbo.i_Layers.T3 AS '~Толщина слоя 3, мм',
dbo.i_Layers.L4 AS '~Материал слоя 4',
dbo.i_Layers.T4 AS '~Толщина слоя 4, мм',
dbo.i_Layers.L5 AS '~Материал слоя 5',
dbo.i_Layers.T5 AS '~Толщина слоя 5, мм',
dbo.i_Layers.L6 AS '~Материал слоя 6',
dbo.i_Layers.T6 AS '~Толщина слоя 6, мм',


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename

FROM         dbo.elements 
INNER JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
INNER JOIN  dbo.i_Layers ON dbo.elements.simID = dbo.i_Layers.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid































GO
