SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- 24/01/2019	Вибе Л.Я.	бэкап перед изменением так как неверные отметки для распределения по подземной/надземной части

CREATE VIEW [dbo].[view_i_FH1_Concrete_group]
AS
SELECT     TOP (100) PERCENT 
	dbo.elements.pwdocID, 
	--dbo.elements.cattype, 
	case 
		when dbo.i_Slab.[Type] is null and dbo.i_Wall.[Type] is not null then dbo.i_Wall.[Type] 
		when dbo.i_Slab.[Type] is not null and dbo.i_Wall.[Type] is null then dbo.i_Slab.[Type] 
		when dbo.i_Slab.[Type] is null and dbo.i_Wall.[Type] is null then dbo.elements.cattype 
		else '-'
	end
		as elemType,
		
	case 
		when 
			dbo.i_Slab.[Type] is null and 
			dbo.i_Wall.[Type] is not null and 
			dbo.i_Wall.Width is not null
			then cast(cast(i_Wall.Width * 0.01 AS bigint) AS varchar)
		when 
			dbo.i_Slab.[Type] is not null and 
			dbo.i_Wall.[Type] is null and 
			dbo.i_Slab.Thickness is not null
			then cast(cast(dbo.i_Slab.Thickness * 0.01 as bigint) AS varchar)
		when 
			dbo.i_Slab.[Type] is null and 
			dbo.i_Wall.[Type] is null 
			then lower(dbo.i_StructuralFramingCommon.sectionname)
		else 
			'-'
	end
		as elemSection,
	
	
	case when dbo.elements.isexternal != 0 then 'Внешн.' else 'Внутр.' end AS [Is External], 
    
    dbo.i_ConcreteProperties.C AS Material, 
    
    case
		-- если отметка не определена
		when dbo.elements.pMinZ = 0 and dbo.elements.pMaxZ = 0 then '-'
		
		-- стена, мин >=
		when dbo.i_Slab.[Type] is null and dbo.i_Wall.[Type] is not null and dbo.elements.pMinZ >= 4800 then 'Надземная часть'
		
		-- плита, макс >
		when dbo.i_Slab.[Type] is not null and dbo.i_Wall.[Type] is null and dbo.elements.pMaxZ > 4800 then 'Надземная часть'
		
		-- колонна как стена
		when dbo.elements.cattype like '%column%' and dbo.elements.pMinZ >= 4800 then 'Надземная часть'
		
		-- балка как плита
		when dbo.elements.cattype like '%beam%' and dbo.elements.pMaxZ > 4800 then 'Надземная часть'
		
		--
		else 'Подземная часть'
    end
		as elemLevel
		
    --,dbo.elements.pMinZ
    --,dbo.elements.pMaxZ
    
    ,LEFT(dbo.i_StructProp.StructCode, 7) as codeLevel
    
    ,SUM(dbo.getTrueVolume(dbo.elements.simID, 0, 3)) AS volume
    
	,case 
		when -- стена прямая
			dbo.i_Slab.[Type] is null 
			and dbo.i_Wall.[Type] is not null
			and isnull(dbo.i_Wall.Curved, 'false') != 'true'
			--then (sum(i_Wall.AreaLeftGross) * 1e-10 + sum(i_Wall.AreaRightGross) * 1e-10)
			then sum(dbo.getTrueVertArea(dbo.elements.simID, 0, 2))
		when -- стена по радиусу - берем аекосимовскую площадь
			dbo.i_Slab.[Type] is null 
			and dbo.i_Wall.[Type] is not null 
			and isnull(dbo.i_Wall.Curved, 'false') = 'true'
			then (sum(i_Wall.AreaLeftGross) * 1e-10 + sum(i_Wall.AreaRightGross) * 1e-10)
			--then sum(dbo.elements.elemvertarea) * 1e-10
		when 
			dbo.i_Slab.[Type] is not null and dbo.i_Slab.[Type] != 'Foundation' and
			dbo.i_Wall.[Type] is null 
			then sum(dbo.i_Slab.AreaBottomNet + dbo.i_Slab.AreaSideGross) * 1e-10
		when 
			dbo.i_Slab.[Type] is not null and dbo.i_Slab.[Type] = 'Foundation' and
			dbo.i_Wall.[Type] is null 
			then sum(dbo.i_Slab.AreaSideGross) * 1e-10
		--when 
		--	dbo.i_Slab.[Type] is null and 
		--	dbo.i_Wall.[Type] is null 
		--	then 0.
		else 
			0.
	end
		as elemArea
    
FROM dbo.elements 


LEFT OUTER JOIN dbo.i_ConcreteProperties 
	ON dbo.elements.simID = dbo.i_ConcreteProperties.simID
LEFT OUTER JOIN dbo.i_Slab
	ON dbo.elements.simID = dbo.i_Slab.simID
LEFT OUTER JOIN dbo.i_Wall
	ON dbo.elements.simID = dbo.i_Wall.simID
LEFT OUTER JOIN dbo.i_StructuralFramingCommon
	ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
LEFT OUTER JOIN dbo.i_StructProp
	ON dbo.elements.simID = dbo.i_StructProp.simID
	
WHERE dbo.elements.cattype like '%concrete%' or dbo.elements.cattype like '%footing%'

	
	
GROUP BY 
	dbo.i_ConcreteProperties.C, 
	dbo.elements.isexternal, 
	dbo.elements.pwdocID, 
	dbo.elements.cattype, 
	dbo.i_Slab.[Type], 
	dbo.i_Wall.[Type],
	dbo.i_Wall.Width,
	dbo.i_Wall.Curved,
	dbo.i_Slab.Thickness,
	dbo.i_StructuralFramingCommon.sectionname
	,dbo.elements.pMinZ
	,dbo.elements.pMaxZ
	,LEFT(dbo.i_StructProp.StructCode, 7)



















GO
