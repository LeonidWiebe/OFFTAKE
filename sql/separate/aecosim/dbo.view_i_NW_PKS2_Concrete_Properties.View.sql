SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[view_i_NW_PKS2_Concrete_Properties]
AS
SELECT  
	dbo.elements.elemID,   
	dbo.elements.elemOldID,
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
-- 6.08.2020, Leonid: добавил в условие cattype, так как Width иногда попадает в балки
case 
	when dbo.elements.cattype='ConcreteWalls' and dbo.i_Wall.Width is not null then cast(cast(i_Wall.Width * 0.01 AS bigint) AS varchar)
	when dbo.elements.cattype='ConcreteSlabs' and dbo.i_Slab.Thickness is not null then cast(cast(dbo.i_Slab.Thickness * 0.01 as bigint) AS varchar)
	when dbo.i_StructuralFramingCommon.sectionname is not null then dbo.i_StructuralFramingCommon.sectionname
	else '-'
end	AS '~Element section',

dbo.i_ConcreteProperties.C AS '~Material',
dbo.i_ConcreteProperties.G AS '~Volume weight',
--dbo.i_ConcreteProperties.D AS '~Density',
dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Volume, м3',


--dbo.i_ConcreteProperties.MM AS '~Manufacturing Metod',
--dbo.i_ConcreteProperties.EC AS '~Execution Class',
dbo.i_ConcreteProperties.RC AS '~Reinforcement class',
--dbo.i_ConcreteProperties.WT AS '~Is Watertight',
Round(dbo.getArmTon(SUBSTRING(dd.bldName, 3, 3)
			,dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem)
			,dbo.getConcrType (dbo.i_Wall.Type, dbo.i_Slab.Type)
			,dbo.elements.isexternal
			,dbo.getTrueVolume(dbo.elements.simID, 0, 3)),3) 
AS '~Weight of reinforcement',


dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename



FROM       dbo.elements 
INNER JOIN dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
LEFT JOIN dbo.i_StructuralFramingCommon ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
LEFT JOIN dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
LEFT OUTER JOIN dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID
WHERE dd.project_name = 'Paks-2' AND dd.deleted = 0



GO
