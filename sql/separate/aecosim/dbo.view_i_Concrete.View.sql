SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







CREATE VIEW [dbo].[view_i_Concrete]
AS
SELECT     
	dbo.elements.simID, 
	dbo.elements.elemID, 
	dbo.elements.pwdocID, 
	dbo.elements.elemguid, 
	dbo.elements.dtID, 
	--case 
	--	when not dbo.elemCodes.codeFull is null then dbo.elemCodes.codeID
	--	else 0
	--end 
	--as codeID,
	dbo.i_StructProp.StructNumber as codeNumID,
	dbo.i_StructProp.ShortCode as codeShortID,
	dbo.elements.cattype, 
	dbo.elements.catitem, 

	case when dbo.i_Stair_Common.FlightPartDef is not null then	dbo.i_Stair_Common.FlightPartDef
	else dbo.elements.partdef
	end as [partdef],
	
	case 
		when dbo.i_Wall.Type is not null then dbo.i_Wall.Type
		when dbo.i_Slab.Type is not null then dbo.i_Slab.Type
		else '-'
	end
	AS [parttype],

	--dbo.i_StructProp.StructCode AS [Civil Code], 
	--case 
	--	when dbo.elemCodes.codeFull is null then dbo.i_StructProp.StructCode 
	--	else dbo.elemCodes.codeFull 
	--end 
	dbo.getConcLevel(doc.dmsstatus, PWRKdoc.dmsstatus, dbo.i_StructProp.StructCode) AS [Civil Code],
	dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS volume, 

	--dbo.elements.elemvertarea AS wallarea, 
	dbo.getTrueVertArea(dbo.elements.simID, 0, 2) AS wallarea, 

	dbo.i_slab.AreaBottomNet as [slabarea],

	dbo.elements.isexternal AS [Is External], 

	dbo.i_Wall.Curved AS [Is Curved], -- добавлено 3/12/2022 Вибе Л.Я. для 30UJA (LAES2006)
	
	case 
		when dbo.i_Wall.Width is not null then cast(cast(i_Wall.Width * 0.01 AS bigint) AS varchar)
		when dbo.i_Slab.Thickness is not null then cast(cast(dbo.i_Slab.Thickness * 0.01 as bigint) AS varchar)
		when dbo.i_StructuralFramingCommon.sectionname is not null then dbo.i_StructuralFramingCommon.sectionname
		else '-'
	end
	AS [section],
	
	dbo.elements.pMinZ AS [Lower Level],
	dbo.elements.pMaxZ AS [Upper Level], 
	dbo.i_ConcreteProperties.Class AS Material
	-- commented 3/12/2022 
	--dbo.i_ConcreteProperties.G AS [Volume Weight],
	--dbo.i_ConcreteProperties.D AS Density, 
	--dbo.i_ConcreteProperties.WT AS [Is Watertight], 
	--dbo.i_ConcreteProperties.FR AS [Is Frost-resistant],
	--dbo.i_ConcreteProperties.FCC AS [Fresh Concrete Composition], 
	--dbo.i_ConcreteProperties.CCW AS [Allowable Concrete Crack Width],
	--dbo.i_ConcreteProperties.SC AS [Surface Class], 
	--dbo.i_ConcreteProperties.OSTC AS [Outer Surface Thermal Conductivity],
	--dbo.i_ConcreteProperties.MM AS [Manufacturing Metod], 
	--dbo.i_ConcreteProperties.APC AS [APC Protecion], 
	--dbo.i_ConcreteProperties.EC AS [Execution Class],
	--dbo.i_ConcreteProperties.RC AS [Reinforcement Class], 
	--dbo.i_ConcreteProperties.CC AS [Concrete Coating], 
	--dbo.i_ConcreteExposure.XC AS [Carbonation corrosion],
	--dbo.i_ConcreteExposure.XD AS [Chlorides corrosion], 
	--dbo.i_ConcreteExposure.XS AS [Sea water corrosion], 
	--dbo.i_ConcreteExposure.XF AS [Freeze Thaw attack],
	--dbo.i_ConcreteExposure.XA AS [Chemical attack], 
	--dbo.i_StructProp.FC AS [Fire Class], 
	--dbo.i_StructProp.DWL AS [Design Working Life],
	--dbo.i_StructProp.BCC AS [Building Consequences Class], 
	--dbo.i_StructProp.SRC AS [Reliability Class], 
	--dbo.i_StructProp.SC AS [Seismic Class],
	--dbo.i_StructProp.NSC AS [Nuclear Safety Class]
	
FROM         dbo.elements 

LEFT OUTER JOIN dbo.i_ConcreteProperties ON dbo.elements.simID = dbo.i_ConcreteProperties.simID -- INNER JOIN
--LEFT OUTER JOIN dbo.i_ConcreteExposure ON dbo.elements.simID = dbo.i_ConcreteExposure.simID  -- INNER JOIN
LEFT OUTER JOIN dbo.i_StructProp ON dbo.elements.simID = dbo.i_StructProp.simID -- INNER JOIN
LEFT OUTER JOIN dbo.i_Wall ON dbo.elements.simID = dbo.i_Wall.simID
LEFT OUTER JOIN dbo.i_Slab ON dbo.elements.simID = dbo.i_Slab.simID
LEFT OUTER JOIN dbo.i_StructuralFramingCommon ON dbo.elements.simID = dbo.i_StructuralFramingCommon.simID
--LEFT OUTER JOIN dbo.elemCodes ON dbo.elements.simID = dbo.elemCodes.simID
LEFT OUTER JOIN dbo.i_Stair_Common ON dbo.elements.simID = dbo.i_Stair_Common.simID

LEFT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON dbo.elements.pwdocID = dd.id
LEFT OUTER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[aep_docdata] AS doc ON dd.o_docguid = doc.docguid

LEFT OUTER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[view_docdata_all] AS PWRKdd ON dbo.elements.pwdocID = PWRKdd.id
LEFT OUTER JOIN [PWRK.SP.SPBAEP.RU].[pw_aep_con].[dbo].[aep_docdata] AS PWRKdoc ON PWRKdd.o_docguid = PWRKdoc.docguid


--WHERE cattype like '%concrete%' or cattype like '%footing%';
WHERE [partdef] like '%concrete%' or dbo.i_Stair_Common.FlightPartDef like '%concrete%';

















GO
