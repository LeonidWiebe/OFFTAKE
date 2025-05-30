SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE VIEW [dbo].[view_i_NW_PKS2_Steel_Properties]
AS
SELECT   
	
	
	
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 


	'Временно элемент превращается Space Reservation' AS 'Space',


--case 
	--when dbo.i_Wall.Width is not null then cast(cast(i_Wall.Width * 0.01 AS bigint) AS varchar)
	--when dbo.i_Slab.Thickness is not null then cast(cast(dbo.i_Slab.Thickness * 0.01 as bigint) AS varchar)
	--when dbo.i_StructuralFramingCommon.sectionname is not null then dbo.i_StructuralFramingCommon.sectionname
	--else '-'
--end	AS '~Element Section',	
--dbo.i_SteelProperties.SM AS '~Steel Grade',
--dbo.i_SteelProperties.SEC AS '~Execution Class',
----dbo.i_SteelProperties.SSC AS '~Service Category',
--dbo.i_SteelProperties.SACC AS '~Atmospheric-Corrosivity Category',
----dbo.i_SteelProperties.SCS AS '~Coating System',
--dbo.i_SteelProperties.SDC AS '~Durability of Coating',


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_SteelProperties ON dbo.elements.simID = dbo.i_SteelProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
LEFT JOIN dbo.i_StructuralFramingCommon ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
LEFT JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
LEFT OUTER JOIN dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID





















GO
