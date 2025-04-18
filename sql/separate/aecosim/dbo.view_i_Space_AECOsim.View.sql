SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






CREATE VIEW [dbo].[view_i_Space_AECOsim]
AS
SELECT     
dbo.elements.simID, 
dbo.elements.elemID, 
dbo.elements.pwdocID, 
dbo.i_Space.Doc2_ID as [Doc2ident], 
dbo.i_Space.number as [Number], 
dbo.i_Space.label as [Label], 
dbo.i_Space.label2 as [Label 2], 

dbo.getTrueSpaceHeight(dbo.elements.simID, 0, 2) AS [Ceiling Height],
	
dbo.i_Space.heightMan as heightMan,

-- Floor Area
dbo.getTrueArea2(dbo.elements.simID, 0, 2)  AS 'Floor Area',

dbo.elements.elemareaMan AS FloorAreaManual,

-- Vertical Area
dbo.getTrueVertArea(dbo.elements.simID, 0, 2) as 'Vertical Area',
dbo.elements.elemvertareaMan as VertAreaManual,

dbo.getTrueVolume(dbo.elements.simID, 0, 2) AS volume,
dbo.elements.elemVolumeMan AS volumeMan,

-- Low Level
dbo.getZeroPlus(round(dbo.elements.pMinZ* 1e-3, 2)) AS [Level],

round(convert(real,dbo.i_space.perimeter) / dbo.elements.uors, 1) as [Perimeter],

-- aecosim attributes...
dbo.i_Space.AccessArea AS [Access Area],
dbo.i_Space.SPF_Speciality AS [Speciality],
dbo.i_Space.SPF_FireLoadGroup AS [Specific fire load value], -- getFireLoadGroup?
dbo.i_Space.SPF_FireHazardClass AS [Fire hazard class],
dbo.i_Space.NumFireComp2 AS [Number of Fire Compartment],
dbo.i_Space.NumFireComp AS [Number of Secondary Fire Compartment],
dbo.i_Space.SignFireComp AS [Number of Safety Division],
dbo.i_Space.SafetyCanal AS [Safety Channel],
dbo.i_Space.ProtectionLevel AS [Protection Level],
dbo.i_Space.RadiationZone AS [Radiation zone],
dbo.i_Space.SPF_TypeOfDetectors AS [Type Of Detectors],
dbo.i_Space.SPF_AvailabilityOfFAS AS [Availability Of FAS],
dbo.i_Space.SPF_AvailOfAFFP AS [Availability Of AFFP],
dbo.i_Space.SPF_FireFightAgent AS [Fire-fight agent],
dbo.i_Space.SPF_FireClassRating AS [Fire resistance class rating of Fire Compartment],

CASE 
	WHEN dbo.i_Space.TopCoatLayer = 'FL1 Epoxy paint' THEN 'FL1'
	WHEN dbo.i_Space.TopCoatLayer = 'FL2 Decontaminable self-leveling floors' THEN 'FL2'
	WHEN dbo.i_Space.TopCoatLayer = 'FL3 Self-leveling floors' THEN 'FL3'
	WHEN dbo.i_Space.TopCoatLayer = 'FL4 Concrete with grinding' THEN 'FL4'
	WHEN dbo.i_Space.TopCoatLayer = 'FL5 Lining with stainless steel' THEN 'FL5'
	WHEN dbo.i_Space.TopCoatLayer = 'FL6 Ceramic tiles' THEN 'FL6'
	WHEN dbo.i_Space.TopCoatLayer = 'FL7 Polyvinylchloride linoleum with thermal insulation base' THEN 'FL7'
	ELSE dbo.i_Space.TopCoatLayer
END AS 'Floor Interior Finish',


CASE 
	WHEN dbo.i_Space.WallInteriorFinish = 'W1 Epoxy paint' THEN 'W1'
	WHEN dbo.i_Space.WallInteriorFinish = 'W2 Decontaminable epoxy paint' THEN 'W2'
	WHEN dbo.i_Space.WallInteriorFinish = 'W3 Water-based paint' THEN 'W3'
	WHEN dbo.i_Space.WallInteriorFinish = 'W4 Acrylic paint' THEN 'W4'
	WHEN dbo.i_Space.WallInteriorFinish = 'W5 Lining with stainless steel' THEN 'W5'
	WHEN dbo.i_Space.WallInteriorFinish = 'W6 Ceramic tiles' THEN 'W6'
	WHEN dbo.i_Space.WallInteriorFinish = 'W6,W3 Ceramic tiles and Water-based paint' THEN 'W6,W3'
	WHEN dbo.i_Space.WallInteriorFinish = 'W5,W1 Lining with stainless steel and Epoxy paint' THEN 'W5,W1'
	ELSE dbo.i_Space.WallInteriorFinish
END AS 'Wall Interior Finish',

CASE 
	WHEN dbo.i_Space.CeilInteriorFinish = 'C1 Epoxy paint' THEN 'C1'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C2 Decontaminable epoxy paint' THEN 'C2'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C3 Water-based paint' THEN 'C3'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C4 Acrylic paint' THEN 'C4'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C5 Lining with stainless steel' THEN 'C5'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C6 Suspended ceiling' THEN 'C6'
	WHEN dbo.i_Space.CeilInteriorFinish = 'C6 Suspended ceiling' THEN 'C6'
	ELSE dbo.i_Space.CeilInteriorFinish
END AS 'Ceil Interior Finish',

dbo.i_Space.FinishingTypes AS [Finishing Types] -- Добавлен новый столбец для архитекторов с выбором типа отделки 14.01.2021

FROM         dbo.elements 
INNER JOIN   dbo.i_Space ON dbo.elements.simID = dbo.i_Space.simID





















GO
