SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









CREATE VIEW [dbo].[view_i_NW_SH12_Floor_Attributes]
AS
SELECT     
	dbo.elements.elemID, 
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
	--dbo.i_FloorFinishProp.FFType AS '`Type',
round(dbo.i_Slab.Thickness * 1e-2, 0,0) AS '~Толщина, мм',
dbo.i_ConcreteProperties.Class AS '~Класс бетона по прочности',
--round(dbo.elements.elemVolume * 1e-15, 2,2) AS '~Объем, м3',
dbo.getTrueArea2(dbo.elements.simID, 0, 2)  AS '~Площадь, м2',
dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Объем, м3',



	
dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],

doc.o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
INNER JOIN   dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID






















GO
