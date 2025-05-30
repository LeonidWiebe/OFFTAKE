SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










CREATE VIEW [dbo].[view_i_NW_SH12_Concrete_Slab_Properties]
AS
SELECT 
	dbo.elements.elemID AS elemID,     
	dbo.elements.simID AS simID, 
	dbo.elements.pwdocID AS pwdocID, 
	dbo.elements.elemguid AS elemguid, 
	dbo.elements.dtID AS dtID, 


round(dbo.i_Slab.Thickness * 1e-2, 2,3) AS '~Толщина, мм',
--dbo.i_Slab.Type AS '~Тип плиты',
dbo.i_ConcreteProperties.Class AS '~Класс бетона по прочности',
CASE 
	WHEN dbo.i_ConcreteProperties.F is null THEN '-'
	WHEN dbo.i_ConcreteProperties.F = '' THEN '-'
	ELSE dbo.i_ConcreteProperties.F
END AS '~Класс бетона по морозостойкости',

CASE 
	WHEN dbo.i_ConcreteProperties.W is null THEN '-'
	WHEN dbo.i_ConcreteProperties.W = '' THEN '-'
	ELSE dbo.i_ConcreteProperties.W
END AS '~Класс бетона по водонепроницаемости',

--round(dbo.elements.elemVolume * 1e-15, 2,2) AS '~Объем, м3',
dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Объем, м3',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename AS o_filename

FROM         dbo.elements 
RIGHT JOIN   dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID
INNER JOIN   dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
































GO
