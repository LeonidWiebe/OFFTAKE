SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 25.03.2018
-- Description:	Получение комплексной велечины для заполнения атрибута по Пакш
--select dbo.getComposition ('Concrete Wall', 'C35/45', '2400', 'XC1', 'XD1', 'XS1', 'XF3', 'XA1')
-- =============================================
CREATE FUNCTION [dbo].[getComposition] 
(
	@Object nvarchar (50),
	@Material   nvarchar(255),
	@VolumeWeight  nvarchar(255),
	@Carbonation   nvarchar(255),
	@Chlorides  nvarchar(255),
	@SeaWater   nvarchar(255),
	@FreezeThawAttack   nvarchar(255),
	@ChemicalAttack   nvarchar(255)
)
RETURNS nvarchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @OutString   nvarchar(255)

	IF @Carbonation not  in ('XC1', 'XC2', 'XC3', 'XC4') 
		SET @Carbonation = ''

	IF @Chlorides not  in ('XD1', 'XD2', 'XD3') 
		SET @Chlorides = ''
		ELSE  set @Chlorides = '/' + @Chlorides
	
	IF @SeaWater not  in ('XS1', 'XS2', 'XS3') 
		SET @SeaWater = ''
		ELSE  set @SeaWater = '/' + @SeaWater
	
	IF @FreezeThawAttack not  in ('XF1', 'XF2', 'XF3', 'XF4') 
		SET @FreezeThawAttack = ''
		ELSE  set @FreezeThawAttack = '/' + @FreezeThawAttack

	IF @ChemicalAttack not  in ('XA1', 'XA2', 'XA3') 
		SET @ChemicalAttack = ''
		ELSE  set @ChemicalAttack = '/' + @ChemicalAttack		

	IF @Object in ('Concrete Wall', 'Concrete Slab', 'Concrete Column', 'Concrete Beam', 'Concrete Stair', 'Unreinforced Concrete')
		SET @OutString = @Material + '-' + @VolumeWeight + '-' + @Carbonation + @Chlorides + @SeaWater + @FreezeThawAttack + @ChemicalAttack 


	RETURN @OutString

END







GO
