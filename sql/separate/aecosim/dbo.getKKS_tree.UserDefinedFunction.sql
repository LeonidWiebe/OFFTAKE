SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO












-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 24.10.2018
-- Description:	Получение KKS в дереве Navisworks
--select [dbo].[getKKS_tree] ('','','','','','','555','1','2','3')
-- =============================================
CREATE FUNCTION [dbo].[getKKS_tree] 
(
	@RoomKKS nvarchar (50),
	@DoorKKS   nvarchar(50),
	@OpeningKKS  nvarchar(50),
	@StrucPropKKS  nvarchar(50),
	@PartKKS   nvarchar(50),
	@WindowKKS   nvarchar(50),
	@WellKKS   nvarchar(50),
	@TypeElement   nvarchar(150),
	@StrainDT	nvarchar(50),
	@StrainStress	nvarchar(50),
	@Project	nvarchar(10),
	@Catitem nvarchar(200)

)
RETURNS nvarchar(150)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Tree nvarchar(150)



	IF @RoomKKS != '' AND @TypeElement = 'Room'
		AND @RoomKKS is NOT NULL
		SET @Tree = @RoomKKS 
		
	ELSE IF @DoorKKS != '' AND @TypeElement = 'Door'
		AND @DoorKKS is NOT NULL
		SET @Tree = @DoorKKS 

	ELSE IF @DoorKKS != '' AND @TypeElement = 'Gate'
		AND @DoorKKS is NOT NULL
		SET @Tree = @DoorKKS 

	ELSE IF @DoorKKS != '' AND @TypeElement = 'Hatch' 
		AND @DoorKKS is NOT NULL
		SET @Tree = @DoorKKS 

	ELSE IF @OpeningKKS != '' AND @TypeElement = 'Opening'
		AND @OpeningKKS is NOT NULL
		SET @Tree = @OpeningKKS 

	ELSE IF @StrucPropKKS != '' AND @TypeElement in ('Concrete Wall','Steel Stair','Concrete Column', 'Concrete Stair', 'Steel Flooring', 'Footing Concrete', 'Steel Liner', 'Unreinforced Concrete', 'Steel Plate','Concrete Slab', 'Steel Platform','Building Frame','Steel Beam','Steel Column', 'Concrete Beam')
		AND @StrucPropKKS is NOT NULL
		AND @Project not like '%Paks-2%'
		SET @Tree = @StrucPropKKS 

	ELSE IF @PartKKS != ''
		AND @PartKKS is NOT NULL
		AND @TypeElement in ('Embedded Part', 'EmbPlateProfile')
		SET @Tree = @PartKKS 


	ELSE IF @WindowKKS != '' AND @TypeElement in ('Louver','Window')
		AND @WindowKKS is NOT NULL
		SET @Tree = @WindowKKS
	
	ELSE IF @StrainDT != '' AND @TypeElement = 'SDS sensor'
		AND @StrainDT is NOT NULL
		SET @Tree = @StrainDT

	ELSE IF @StrainStress != '' AND @TypeElement = 'CPS duct'
		AND @StrainStress is NOT NULL
		SET @Tree = @StrainStress

	ELSE IF @TypeElement = 'Furniture'
		SET @Tree = @Catitem

	ELSE IF @TypeElement = 'Physical Protection element'
		SET @Tree = @Catitem

	ELSE IF @WellKKS != '' AND @TypeElement = 'Well'
		AND @WellKKS is NOT NULL
		SET @Tree = @WellKKS


--	ELSE IF @TypeElement = 'Waterstop' -- закомментировано Покуль по просьбе Пака Константина 10.04.2021
--		SET @Tree = @Catitem


	ELSE 
		SET @Tree = @TypeElement
	
	RETURN @Tree

END










GO
