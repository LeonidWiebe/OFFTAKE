SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[view_i_NW_FH1_ReinConcrete_Properties]
AS
SELECT  
	dbo.elements.elemID,   
	dbo.elements.simID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	
	--case 
	--	when dbo.i_Wall.Width is not null then cast(cast(i_Wall.Width * 0.01 AS bigint) AS varchar)
	--	when dbo.i_Slab.Thickness is not null then cast(cast(dbo.i_Slab.Thickness * 0.01 as bigint) AS varchar)
	--	when dbo.i_StructuralFramingCommon.sectionname is not null then dbo.i_StructuralFramingCommon.sectionname
	--	else '-'
	--end	AS '~Section (Thickness), mm',
	
dbo.i_ReinConcreteProperties.C AS '~Material',
dbo.i_ReinConcreteProperties.G AS '~Volume weight',
dbo.i_ReinConcreteProperties.D AS '~Density',
dbo.getTrueVolume(dbo.elements.simID, 0, 3) AS '~Volume',

-- 6.08.2020, Leonid: добавил в условие cattype, так как Width иногда попадает в балки
case 
	when dbo.elements.cattype='ReinforcedConcreteFloor' and dbo.i_Slab.Thickness is not null then 'Thickness: ' + cast(cast(dbo.i_Slab.Thickness * 0.01 as bigint) AS varchar)
	when dbo.i_StructuralFramingCommon.sectionname is not null then 'Section: ' +  dbo.i_StructuralFramingCommon.sectionname
	else '-'
end	AS '~Thickness',

dbo.i_ReinConcreteProperties.FCC AS '~Fresh concrete composition',
--dbo.i_ReinConcreteProperties.CCW AS '~Allowable concrete crack width',
--dbo.i_ReinConcreteProperties.SC AS '~Surface class',
--dbo.i_ReinConcreteProperties.OSTC AS '~Thermal transmittance',
--dbo.i_ReinConcreteProperties.MM AS '~Manufacturing method',
dbo.i_ReinConcreteProperties.EC AS '~Execution class',
dbo.i_ReinConcreteProperties.RC AS '~Reinforcement class',
--dbo.i_ReinConcreteProperties.CC AS '~Concrete coating',
--dbo.i_ReinConcreteProperties.WT AS '~Is Watertight',
--dbo.i_ReinConcreteProperties.APC AS '~APC protection',
dbo.i_ReinConcreteProperties.DWL AS '~Design Working Life',

dbo.getTypeElement(dbo.elements.cattype, dbo.elements.partdef, dbo.elements.catitem) AS [Object],
doc.o_filename


FROM         dbo.elements 
INNER JOIN   dbo.i_ReinConcreteProperties ON dbo.elements.simID = dbo.i_ReinConcreteProperties.simID
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[dms_doc] AS doc ON dd.o_docguid = doc.o_docguid
LEFT JOIN dbo.i_StructuralFramingCommon ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
LEFT JOIN   dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
LEFT OUTER JOIN dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID



























GO
