SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Pokul Anna
-- Create date: 18.07.2019
-- Description:	Получение марок дверей по проекту ТАЭС 7-8,
-- Select dbo.getLYG_Door_Mark('Н','П2','','К','Б','У','3Н','I','','','','D01','D04h-1300х2200')
-- Select dbo.getLYG_Door_Mark('@Location','@FireResistance','@Tightness','@RemoteControl','Е@Lock','@ShockWave','@SafetyClass','@SeismicClass','@OtherFunctions','@Locks','@Opening','@DimensionType','@catitem', 'Material')
-- =============================================
CREATE FUNCTION [dbo].[getLYG_Door_Mark]
(
	@Location varchar (200), -- место расположение двери/ворот
	@FireResistance varchar (200),-- предел огнестойкости
	@Tightness varchar (200), -- степень герметичности
	@RemoteControl varchar (200), -- дистанционный контроль
	@Lock varchar (200), -- блокировка
	@ShockWave varchar (200), -- ударная волна
	@SafetyClass varchar (200), -- класс безопасности
	@SeismicClass varchar (200), --класс сейсмостойкости
	@OtherFunctions varchar (200), -- другие функции
	@ElectricalDrive varchar (200), -- электропривод
	@Locks varchar (200), -- замок
	@Opening varchar (200), -- открывание
	@DimensionType varchar (200), -- типа двери/ворот
	@Material varchar (200), -- материал
	@catitem varchar (200)


)
RETURNS varchar (200)
AS
BEGIN
	
	DECLARE @DoorMark varchar (200)
	DECLARE @varchar  varchar(50)

	IF @Locks = 'не требуется'
	SET @Locks = ''

	IF @Opening = 'не требуется'
	SET @Opening = ''

	------------- D O O R -----------------	

	IF LEFT(@DimensionType,1) = 'D'
	begin

	IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 01'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 02'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness = 'не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 03'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 04'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 05'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 06'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness = 'не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 07'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness = 'не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='III' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 08'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness = 'Г' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 09'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness = 'Г' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 10'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness = 'Г' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 11'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'Г' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 12'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'Г' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 13'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'Г' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 14'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness = 'Г' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 15'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='Г' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 16'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='S'
	SET @DoorMark = @DimensionType+' - 17'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='S'
	SET @DoorMark = @DimensionType+' - 18'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I'AND @OtherFunctions ='S' AND @Material ='сталь' AND @OtherFunctions ='S'
	SET @DoorMark = @DimensionType+' - 19'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='S'
	SET @DoorMark = @DimensionType+' - 20'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='не металл' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 21'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='T'
	SET @DoorMark = @DimensionType+' - 22'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 23'+@Opening+@Locks
		
	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='III' AND @Material ='не металл' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 24'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 25'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 26'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 27'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='X'
	SET @DoorMark = @DimensionType+' - 28'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='X' 
	SET @DoorMark = @DimensionType+' - 29'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='III' AND @Material ='сталь' AND @OtherFunctions ='X'  
	SET @DoorMark = @DimensionType+' - 30'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 31'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness ='Г' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 32'+@Opening+@Locks
	
	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 33'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 34'+@Opening+@Locks
	
	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 35'+@Opening+@Locks
		
	ELSE IF @Location ='Н' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 36'+@Opening+@Locks
			
	ELSE IF @Location ='Н' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 37'+@Opening+@Locks
				
	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 38'+@Opening+@Locks
					
	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 39'+@Opening+@Locks
						
	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='Г' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 40'+@Opening+@Locks
						
	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 41'+@Opening+@Locks
							
	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 42'+@Opening+@Locks
							
	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 43'+@Opening+@Locks
								
	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 44'+@Opening+@Locks
									
	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness ='Г' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='У' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 45'+@Opening+@Locks
										
	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='III' AND @Material ='не металл' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 46'+@Opening+@Locks
											
	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 47'+@Opening+@Locks
												
	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 48'+@Opening+@Locks
													
	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 49'+@Opening+@Locks
														
	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness ='не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 50'+@Opening+@Locks
															
	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='T'
	SET @DoorMark = @DimensionType+' - 51'+@Opening+@Locks
																
	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness ='Г' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='X'
	SET @DoorMark = @DimensionType+' - 52'+@Opening+@Locks

	end

	------------- G A T E ---------------

	IF LEFT(@DimensionType,1) = 'G'
	begin

	IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ElectricalDrive ='ПР' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 01'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ElectricalDrive ='ПР' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 02'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ElectricalDrive ='ПР' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 03'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ElectricalDrive ='ПР' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 04'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='не требуется' AND @Lock ='Б' AND @ElectricalDrive ='ПР' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 05'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ElectricalDrive ='ПР' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='II' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 06'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ElectricalDrive ='ПР' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='III' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 07'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ElectricalDrive ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 08'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ElectricalDrive ='не требуется' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @Material ='сталь' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 09'+@Opening+@Locks

	end


	------------- M A N H O L E ---------------

	IF LEFT(@DimensionType,1) = 'A'
	begin

	IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='3Н' AND @SeismicClass ='I' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 01'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 02'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 03'+@Opening+@Locks

	ELSE IF @Location ='Н' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='Б' AND @ShockWave ='У' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 04'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П1' AND @Tightness = 'не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 05'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='не требуется' AND @Tightness = 'не требуется' AND @RemoteControl ='не требуется' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 06'+@Opening+@Locks

	ELSE IF @Location ='В' AND @FireResistance ='П2' AND @Tightness = 'не требуется' AND @RemoteControl ='К' AND @Lock ='не требуется' AND @ShockWave ='не требуется' AND @SafetyClass ='4' AND @SeismicClass ='I' AND @OtherFunctions ='не требуется'
	SET @DoorMark = @DimensionType+' - 07'+@Opening+@Locks
	end


	IF @Tightness != 'Г' AND SUBSTRING(@catitem,4,1) = 'h' 
	SET @DoorMark = 'несоотв. "Г" и блока двери'


-- Select dbo.getLYG_Door_Mark('Н','П2','','К','Б','У','3Н','I','','','','D01','D04h-1300х2200')

	RETURN @DoorMark

END









GO
