SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 26.07.2017
-- Description:	Получение Типов элементов путем сопастовления Каталожного элемента,
-- Part Def, Каталог Item
-- =============================================
CREATE FUNCTION [dbo].[getTypeElement]
(
	@cattype varchar (200),
	@partdef varchar (200),
	@catitem varchar (200)
)
RETURNS varchar (200)
AS
BEGIN
	
	DECLARE @TypeElement varchar (200)

	IF @cattype in ('SpaceReservation', 'SpaceReservationWall')
	SET @TypeElement = 'Space reservation'
	
	ELSE IF @cattype = 'BuildingExternalOutline'
	SET @TypeElement = 'Building external outline'
	
	ELSE IF @cattype = 'Space'
	SET @TypeElement = 'Room'
	
	ELSE IF @cattype = 'Wall' AND @partdef in ('Concrete_Radiation Shilding_2::Walls',
		'Construction_Standart::Walls', 
		'Concrete_Hydrophobic_FR::Walls',
		'C50_60 XS1 G2400::Walls',
		'Concrete_Radiation Shilding_2::Walls', 
		'Concrete_Hydrophobic::_Concrete_Hydrophobic',
		'Concrete_High-strength_Hydro::_Concrete_High-strength_H',
		'C50_60 XS1 G2400::Walls',
		'Concrete_High-strength_Hydro::Walls',
		'Concrete_Hydrophobic::Walls', 
		'Concrete_Hydrophobic::Walls', 
		'Concrete_High-strength::Walls', 
		'C35_45 XS1 G2400::Walls', 
		'Concrete_Standart::_Concrete_Standart',
		'Concrete_High-strength::Walls',
		'C35_45 XS3 G2400 F300 W20::Walls',
		'Concrete_Standart::Slabs', 
		'Concrete_Radiation Shilding_2::Walls', 
		'Concrete_Standart::Walls',
		'Concrete_Radiation Shilding_1::Beams',
		'Concrete_Standart::Walls', 'Concrete_Standart::Walls_per',
		'Concrete_High-strength::Beams',
		'Wall')
	SET @TypeElement = 'Concrete wall'
	
		ELSE IF @cattype ='Wall'
		AND @partdef ='Concrete_Standart::Beams'
	SET @TypeElement = 'Concrete wall'
	
	ELSE IF @cattype = 'ConcreteWalls'
	SET @TypeElement = 'Concrete wall'
	
	ELSE IF @cattype = 'Wall' 
		AND @partdef in ('ThreePly Wall Panel 100', 'Fin_compound::Wall_panel_100')
	SET @TypeElement = 'Wall layer'	
	
	ELSE IF @cattype = 'WallLeaf' 
	SET @TypeElement = 'Wall layer'	
	
	ELSE IF @cattype = 'CompoundWalls' 
	SET @TypeElement = 'Wall layer'	
		
	ELSE IF @cattype = 'ConcreteSlabs'
	SET @TypeElement = 'Concrete slab'
	
	ELSE IF @cattype = 'Concrete Beam'
	SET @TypeElement = 'Concrete beam'
	
	ELSE IF @cattype = 'Concrete Column'
	SET @TypeElement = 'Concrete column'
		
	ELSE IF @cattype = 'Slab'
		AND @partdef in ('Concrete_High-strength::Slabs',
											'Concrete_Standart::Slabs',
											'Concrete_Hydrophobic::Slabs',
											'Concrete_Hydrophobic::Slabs',
											'Construction_Standart::Slabs',
											'Concrete_Hydrophobic_FR::Slabs',
											'Concrete_High-strength_Hydro::_Concrete_High-strength_H',
											'C35_45 XS3 G2400 F300 W20::Slabs',
											'C35_45 XS1 G2400::Slabs',
											'Concrete_Hydrophobic::_Concrete_Hydrophobic',
											'C35_45 XS1 G3700::Slabs',
											'Concrete_Radiation Shilding_2::Slabs',
											'Concrete_High-strength_Hydro::Beams',
											'Concrete_Radiation Shilding_1::_Concrete_Radiation Shilding_1',
											'Concrete_Radiation Shilding_1::Beams', 'Concrete_High-strength_Hydro::Slabs',
											'Concrete_High-strength::Slabs',
											'Concrete_Standart::Walls')
	
	SET @TypeElement = 'Concrete slab'
	
	ELSE IF @cattype ='Slab'
		AND @partdef ='Concrete_Standart::Beams'
	SET @TypeElement = 'Concrete slab'
	
	ELSE IF @cattype = 'ConcreteSlabs'
		AND @partdef in ('C35_45 XS1 G2400::Equipment_footing',
											'Concrete_Standart::Equipment_footing',
											'Concrete_Standart::Slabs')
		
	SET @TypeElement = 'Equipment footing'
	
	ELSE IF @cattype in ('ConcreteSlabs', 'Slab', 'Stair', 'ConcreteStair')
		AND @partdef in ('Concrete_Standart::Stairs')
	SET @TypeElement = 'Concrete stair'
	
	ELSE IF @cattype in ('ConcreteStair')
	SET @TypeElement = 'Concrete stair'
	
		
	ELSE IF @cattype ='Stair'
		AND @catitem in ('ConcreteStair | Monolithic','Fin_Concrete Monolithic Stair')
	SET @TypeElement = 'Concrete stair'
	
	
	ELSE IF @cattype ='Stair'
		AND @partdef in ('FH1_Steel Stair 45deg', '')
	SET @TypeElement = 'Steel stair'
	
	ELSE IF @cattype in ('ConcreteSlabs', 'Slab', 'Wall','MassFillSlabs') 
		AND @partdef in ('Concrete_Mass fill::Concrete_Mass fill',
											'Concrete filling::Concrete filling',
											'Concrete_Mass fill::Mass fill new Gravel',
											'Concrete_Mass fill::Mass fill new',
											'Concrete_Mass fill::Mass fill new Concr2')
	SET @TypeElement = 'Unreinforced concrete'
	
	ELSE IF @cattype = 'MassFillSlabs'
	SET @TypeElement = 'Unreinforced concrete'
	
	ELSE IF @cattype = 'ReinforcedConcreteFloor'
	SET @TypeElement = 'Reinforced concrete floor'

	ELSE IF @cattype = 'FootingSlabs'
	SET @TypeElement = 'Footing'
	
	ELSE IF @cattype = 'WaterproofSlabs'
	SET @TypeElement = 'Waterproof'
	
	ELSE IF @cattype = 'WaterproofWalls'
	SET @TypeElement = 'Waterproof'

	ELSE IF @partdef = 'Waterproofing::Waterstop' -- добавлено Покуль по просьбе Пака Константина 10.04.2021
	SET @TypeElement = 'Waterstop'

	ELSE IF @cattype = 'Window'
	SET @TypeElement = 'Window'

	ELSE IF @cattype = 'CurtainWall'
	SET @TypeElement = 'Curtain wall'
	
	ELSE IF @cattype = 'EmbeddedPart'
	SET @TypeElement = 'Embedded part'
		
	ELSE IF @cattype = 'Embedded Parts'
	SET @TypeElement = 'Embedded part'

	ELSE IF @cattype = 'ESC-ROUT'
	AND @catitem = 'ESC-ROUT'
	SET @TypeElement = 'Escape route'
	
	ELSE IF @cattype = 'ESC-ROUT'
	AND @catitem = 'PassageWay'
	SET @TypeElement = 'Passage way'
	
	ELSE IF @cattype = 'ESC-ROUT'
	AND @catitem = 'EXIT-ROUT'
	SET @TypeElement = 'Passage way'
	
	ELSE IF @cattype = 'ET-ROUT'
	SET @TypeElement = 'Equipment transportation route'

	ELSE IF @cattype = 'FinishFloorSlabs'
	SET @TypeElement = 'Floor'
	
	ELSE IF @cattype = 'InsulationSlabs'
	SET @TypeElement = 'Insulation'
	
	ELSE IF @cattype = 'InsulationWalls'
	SET @TypeElement = 'Insulation'

	ELSE IF @cattype = 'PromatWalls'
	SET @TypeElement = 'Promat'
	
	ELSE IF @cattype = 'PromatSlabs'
	SET @TypeElement = 'Promat'
	
	ELSE IF @cattype = 'Slab' 
		AND @partdef in ('Insulation_Standart::_Insulation_Standart')
	SET @TypeElement = 'Insulation'
	
	ELSE IF @cattype = 'Wall' 
		AND @partdef in ('Insulation_Standart::_Insulation_Standart')
	SET @TypeElement = 'Insulation'
	
	ELSE IF @cattype = 'Wall' 
		AND @partdef in ('Waterproofing::Insulation')
	SET @TypeElement = 'Insulation'
	
	ELSE IF @cattype = 'Wall' 
		AND @partdef = 'Brick_Standart::_Brick_Standart'
	SET @TypeElement = 'Brick wall'
	
	ELSE IF @cattype = 'BrickWalls'
	SET @TypeElement = 'Brick wall'
	
	ELSE IF @cattype in ('ConcreteSlabs', 'Slab', 'MassFillSlabs')
		AND @partdef = 'Concrete_Mass fill::Footing Concrete'
	SET @TypeElement = 'Footing concrete'
	
	ELSE IF @cattype = 'Ladders'
	SET @TypeElement = 'Ladder'
	
	ELSE IF @cattype = 'Door'AND (left(@catitem,1)!='G' AND left(@catitem,1)!='H')
	SET @TypeElement = 'Door'

	ELSE IF @cattype = 'Door' AND left(@catitem,1)='G'
	SET @TypeElement = 'Gate'

	ELSE IF @cattype = 'Door' AND left(@catitem,1)='H'
	SET @TypeElement = 'Hatch'

	ELSE IF @cattype = 'Ceiling'
	SET @TypeElement = 'Ceiling'
	
	ELSE IF @cattype = 'Louver'
	SET @TypeElement = 'Louver'
	
	ELSE IF @cattype = 'ToiletCompartment'
	SET @TypeElement = 'Toilet compartment'
	
	ELSE IF @cattype = 'PlumbingFixtures'
	SET @TypeElement = 'Plumbing fixtures'
	
	ELSE IF @cattype in ('Profile', 'WaterstopProfiles')
		AND @partdef in ('Waterproofing::Waterstop', 'Waterproofing::Watwerstop')
	SET @TypeElement = 'Waterstop'
	
	ELSE IF @cattype = 'Railing'
	SET @TypeElement = 'Railing'
	
	ELSE IF @cattype = 'Roof'
	SET @TypeElement = 'Roof'
	
	ELSE IF @cattype in ('SteelSlabsLiner', 'SteelWallsLiner')
	SET @TypeElement = 'Steel liner'
	
	ELSE IF @cattype in ('Slab', 'Wall') 
		AND @partdef in ('Steel_Stainless::Liner', 
											'Steel_Carbon::Liner',
											'Steel_Stainless::Liner',
											'Steel_Carbon::Beam')
	SET @TypeElement = 'Steel liner'
	
	ELSE IF @cattype = 'Slab'
		AND @partdef = 'Steel_Carbon::Plate'
	SET @TypeElement = 'Steel plate'
	
	ELSE IF @cattype = 'Slab'
		AND @catitem = 'Steel plate'
	SET @TypeElement = 'Steel plate'
	
	ELSE IF @cattype in ('SteelSlabsPlate', 'SteelWallsPlate') 
	SET @TypeElement = 'Steel plate'
	
	ELSE IF @cattype in ('Slab', 'SteelSlabs', 'SteelSlabsFlooring') 
		AND @partdef = 'Steel_Carbon::Flooring'
	SET @TypeElement = 'Steel flooring'
	
	ELSE IF  @catitem  = 'Steel flooring'
	SET @TypeElement = 'Steel flooring'
	
	ELSE IF @cattype = 'Steel Beam'
	SET @TypeElement = 'Steel beam'
	
	ELSE IF @cattype = 'Steel Column'
	SET @TypeElement = 'Steel column'
	
	ELSE IF @cattype = 'SteelSlabsFlooring'
	SET @TypeElement = 'Steel liner'

	ELSE IF @cattype in ('SteelPlatform', 'Steel Cladding')
	SET @TypeElement = 'Steel platform'

	ELSE IF @cattype = 'BuildingFrame'
	SET @TypeElement = 'Building frame'
	
	ELSE IF @cattype = 'Slab' 
		AND @partdef = 'Concrete_Mass fill::Finishing floor'
	SET @TypeElement = 'Floor'

	ELSE IF @cattype = 'GroundSlabs' 
		SET @TypeElement = 'Backfill'

	ELSE IF @cattype = 'Slab' 
		AND @partdef = 'sand::sand'
	SET @TypeElement = 'Backfill'

	ELSE IF @cattype = 'StrainDT' 
	SET @TypeElement = 'SDS sensor'

	ELSE IF @cattype = 'StrainStress' 
	SET @TypeElement = 'CPS duct'

	ELSE IF @cattype = 'SDS sensor' 
	SET @TypeElement = 'SDS sensor'

	ELSE IF @cattype = 'CPS duct' 
	SET @TypeElement = 'CPS duct'

	
	ELSE IF @cattype = 'Opening'
	SET @TypeElement = 'Opening'
	
	
	ELSE IF @cattype = 'Penetrations'
	SET @TypeElement = 'Opening'


	ELSE IF @cattype = 'RoofCovering'
	SET @TypeElement = 'Roof covering'

	ELSE IF @cattype = 'Specialty_Roof' 
	AND @catitem = 'Downspout | Rectangular'
	SET @TypeElement = 'Downspout'

	IF @cattype = 'EmbPlateProfile'
	SET @TypeElement = 'EmbPlateProfile'

	IF @cattype = 'EmbPlateLoad'
	SET @TypeElement = 'EmbPlateLoad'

	IF @cattype in ('Furniture', 'Specialty_Interior')
	SET @TypeElement = 'Furniture'

	ELSE IF @cattype = 'LevelingConcrete'
	SET @TypeElement = 'Leveling concrete'

	ELSE IF @cattype = 'OSFZ'
	SET @TypeElement = 'Physical Protection element'
	
	ELSE IF @cattype = 'Reinforcement'
	SET @TypeElement = 'Reinforcement'

	ELSE IF @cattype = 'Drain Pipe'
	SET @TypeElement = 'Drain Pipe'

	IF @cattype in ('CrushedStoneSlabs', 'CrushedStone')
	SET @TypeElement = 'Crushed Stone'

	ELSE IF @cattype = 'Well'
	SET @TypeElement = 'Well'

------------Electrical--------------------	

	ELSE IF @cattype like 'CABLE_LADDER%'
	SET @TypeElement = 'Cable routes'

	IF @TypeElement is NULL
	SET  @TypeElement = 'Lost'

	RETURN @TypeElement

END



























GO
