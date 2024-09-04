SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 22.07.2019
-- Description:	Определение дублия закладной в различных каталогах в оффтэйк
--select dbo.getDuplicate('10UKA13BQ3001')

-- =============================================
CREATE FUNCTION [dbo].[getDuplicate] 
(
	@PartName varchar (50)
)
RETURNS nvarchar(100)
--RETURNS int
AS
BEGIN


	declare @PartCatID bigint;
	declare @AECnnn varchar(500);
	declare @AECcatID bigint;
	--declare @Root varchar(500);
	declare @con int;
	set @con = 0;


--WHILE  @con<=10 
--Begin

declare c1 cursor for
		SELECT 
		p.partName,
		p.catID
		FROM [parts].[dbo].[part] p WHERE p.partName = @PartName
open c1 
fetch next from c1 into

	--declare @PartName varchar(500);
	--declare @PartCatID bigint;
	--declare @con int;
	--set @con = 0;		
	
	
	@AECnnn,
	@AECcatID
	while @@FETCH_STATUS = 0
	Begin 
	IF @con > 10 or @AECcatID is null  break
		set @AECnnn = @PartName
		set @AECcatID = @PartCatID 
		set @con = @con + 1
		
	end
	close c1
		deallocate c1
	
	
		
		--SET @Root = @PartName
		--SET @AECcatID = @PartCatID
		--IF @AECcatID is NULL BREAK
--Set @con=@con+1;
--END





--		SELECT 
--		@AECnnn=a.nnn,
--		@AECcatID=a.catID
--		FROM dbo.view_i_FH1_EmbPart_Wise_Offtake a WHERE a.catID = @PartCatID
--END
--open c2
--fetch next from c1 into 


--while @@FETCH_STATUS = 0

		--IF COUNT(@AECcatID) = 1 
		--SET @Root='Дуль в каталог.'+@AECnnn
		
		
		--RETURN @Root
	RETURN @con



END



GO
