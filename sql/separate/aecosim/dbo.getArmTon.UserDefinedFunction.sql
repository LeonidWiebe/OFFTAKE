SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 17.08.2019
-- Description:	Получение Массы армирования для проекта Пакш-2
-- Select dbo.getArmTon('@Building','@ElemModel', '@TypeConstruct','@Isexternal','@Volume')
-- Select dbo.getArmTon('UCB','ConcreteSlabs', 'Foundation','0','5.3')
-- =============================================
CREATE FUNCTION [dbo].[getArmTon]
(
	@Building varchar (200),
	@ElemModel varchar (200),
	@TypeConstruct varchar (200),
	--@Section varchar (200),
	@Isexternal bit,
	@Volume real 
)
RETURNS real  
AS
BEGIN
	
	DECLARE @ArmTonn real 
	
	IF @Building in ('UCB','UKD','UJE','UJG','UKA','UKT') AND @ElemModel = 'Concrete Slabs' AND  @TypeConstruct = 'Foundation'
	SET @ArmTonn = @Volume * 0.296

	Else IF @Building in ('UCB','UKD','UJE','UJG','UKA','UKT') AND @ElemModel = 'Concrete Slabs' AND  @TypeConstruct = 'Roof'
	SET @ArmTonn = @Volume * 0.290

	Else IF @Building in ('UCB','UKD','UJE','UJG','UKA','UKT') AND @ElemModel = 'Concrete Slabs' AND  @TypeConstruct = 'Floor'
	SET @ArmTonn = @Volume * 0.255

	Else IF @Building in ('UCB','UKD','UJE','UJG','UKA','UKT') AND @ElemModel = 'Concrete Wall' AND  @Isexternal = '1'
	SET @ArmTonn = @Volume * 0.280

	Else IF @Building in ('UCB','UKD','UJE','UJG','UKA','UKT') AND @ElemModel = 'Concrete Wall' AND  @Isexternal = '0'
	SET @ArmTonn = @Volume * 0.250

	Else IF @Building in ('UCB','UKD','UJE','UJG','UKA','UKT') AND @ElemModel = 'Concrete Column'
	SET @ArmTonn = @Volume * 0.510

	Else IF @Building in ('UCB','UKD','UJE','UJG','UKA','UKT') AND @ElemModel = 'Concrete Beam'
	SET @ArmTonn = @Volume * 0.510

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Slabs' AND  @TypeConstruct = 'Foundation'
	SET @ArmTonn = @Volume * 0.265

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Slabs' AND  @TypeConstruct = 'Roof'
	SET @ArmTonn = @Volume * 0.270

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Slabs' AND  @TypeConstruct = 'Floor'
	SET @ArmTonn = @Volume * 0.260

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Wall' AND  @Isexternal = '1' AND @TypeConstruct != 'Reactor Shaft'
	SET @ArmTonn = @Volume * 0.280

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Wall' AND  @Isexternal = '0' AND @TypeConstruct != 'Reactor Shaft'
	SET @ArmTonn = @Volume * 0.260

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Wall' AND @TypeConstruct = 'Reactor Shaft'
	SET @ArmTonn = @Volume * 0.500

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Column'
	SET @ArmTonn = @Volume * 0.512

	Else IF @Building = 'UJA' AND @ElemModel = 'Concrete Beam'
	SET @ArmTonn = @Volume * 0.512

	--Else IF @ElemModel not in ('Concrete Beam', 'Concrete Column','Concrete Slab','Concrete Stair','Concrete Wall')
	--SET @ArmTonn = @Volume * 0

	ELSE
	SET @ArmTonn = @Volume * 0.260

	RETURN @ArmTonn
END




GO
