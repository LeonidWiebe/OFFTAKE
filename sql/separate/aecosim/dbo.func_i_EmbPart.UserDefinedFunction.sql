SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[func_i_EmbPart]
(
	@pwDocID bigint, -- pwDocIDsTable readonly,
	@pdsID bigint,
	@catID bigint
)
RETURNS 
@retPartsTable TABLE 
(
	simID bigint,
	elemID bigint,
	pwDocID bigint,
	partID bigint,
	catID bigint,
	--bldCode varchar(10),
	[Number] int,
	[Civil Code] varchar(50),
	[Catalog Name] varchar(100),
	[Type] varchar(100),
	[Section] varchar(50),
	[Material] varchar(150),
	[Surface] varchar (50),
	[PointX] bigint,
	[PointY] bigint,
	[PointZ] bigint,
	[Drawing] varchar(100),
	[Supplier] varchar(100)
)
AS
BEGIN


	declare @simID bigint = 0
	declare @elemID bigint = 0
	--declare @pwDocID bigint = 0
	declare @partID bigint = 0
	--declare @partDefID bigint = 0
	declare @partTypeID bigint = 0
	declare @partCatID bigint = 0
	declare @num bigint = 0
	
	declare @bldCode varchar(10)
	declare @partName varchar(100)
	declare @partCode varchar(50)
	declare @partType varchar(100)
	declare @posSecName varchar(50)
	declare @posMatName varchar(150)
	declare @partDrawNum varchar(100)
	declare @partSupplier varchar(100)
	declare @posStdNum varchar(100)
	
	declare @posSection varchar(100) = ''

	declare @posLen int;
	
	declare @posThick int;
	declare @posThick1 int;
	declare @posThick2 int;
	declare @posThick3 int;
	declare @posThick4 int;
	
	declare @posWdt int;
	declare @posWdt1 int;
	declare @posWdt2 int;
	
	declare @posDiam int;
	
	--declare @partDefRem bigint = -1
	declare @partTypeRem bigint = -1
	
	declare @pCentX bigint;
	declare @pCentY bigint;
	declare @pCentZ bigint;

	declare c1 cursor read_only for 
		select 
			p.simID, 
			p.elemID, 
			p.pwdocID, 
			p.PartCode, 
			p.Drawing, 
			p.Supplier,
			p.CatalogName,
			p.typeID,
			p.thickness,
			p.s_thickness,
			p.s_horthickness,
			p.s_verthickness,
			p.s_diameter,
			p.width,
			p.s_width,
			p.length,
			p.matName,
			p.stdFullNumber,
			p.partID,
			p.pCentX,
			p.pCentY,
			p.pCentZ
		from dbo.view_i_FH1_EmbPart p 
		where p.catID = @catID
		--where p.pwdocID = @pwDocID
		--where p.pwdocID in (select pwDocID from @pwDocIDs)

	open c1
	
	fetch next from c1 into 
		@simID, 
		@elemID, 
		@pwDocID, 
		@partCode, 
		@partDrawNum, 
		@partSupplier, 
		@partName, 
		@partTypeID,
		@posThick1,
		@posThick2,
		@posThick3,
		@posThick4,
		@posDiam,
		@posWdt1,
		@posWdt2,
		@posLen,
		@posMatName,
		@posStdNum,
		@partID,
		@pCentX,
		@pCentY,
		@pCentZ

	while @@FETCH_STATUS = 0
	begin
		--=================================
		
	
		--if @partDefID != @partDefRem
		--begin
		--	select @partDef = aa.relNameAlt from parts.dbo.r_pdset_partdef aa 
		--		where aa.pdsID = @pdsID and aa.partdefID = @partDefID
		--	if @partDef is null select @partDef = aa.partdefName from parts.dbo.partdef aa 
		--		where aa.partdefID = @partDefID
		--	if not @partDef is null set @partDefRem = @partDefID
		--end
		
		
		if @partTypeID != @partTypeRem
		begin
		
			-- первоначальный вариант
			--select @partType = aa.relNameAlt from parts.dbo.r_pdset_parttype aa 
			--	where aa.pdsID = @pdsID and aa.ptID = @partTypeID
				
			--if @partType is null select @partType = aa.typeName from parts.dbo.parttype aa 
			--	where aa.typeID = @partTypeID
			-------------------------
			select @partType = aa.typeName from parts.dbo.parttype aa 
				where aa.typeID = @partTypeID
			-----------------------
		
			if not @partType is null set @partTypeRem = @partTypeID
			
		end
		
		--simID bigint,
		--elemID bigint,
		--pwDocID bigint,
		--partID bigint,
		--catID bigint,
		--bldCode varchar(10),
		--partCode varchar(50),
		--partDef varchar(100),
		--partType varchar(100),
		--posSecName varchar(50),
		--posMatName varchar(150),
		--partDrawNum varchar(100),
		--partSupplier varchar(100)
	
		set @num = @num + 1
		
		--===== section ====
		set @posSection = ''
		
		if not @posThick4 is null set @posThick = @posThick4
		if not @posThick3 is null set @posThick = @posThick3
		if not @posThick2 is null set @posThick = @posThick2
		if not @posThick1 is null set @posThick = @posThick1
		
		if not @posWdt2 is null set @posWdt = @posWdt2
		if not @posWdt1 is null set @posWdt = @posWdt1
		
		if not @posThick is null set @posSection = convert(varchar, @posThick)
			
		if not @posWdt is null
		begin
			if LEN(@posSection) > 0
				set @posSection = @posSection + 'x' + convert(varchar, @posWdt)
			else
				set @posSection = convert(varchar, @posWdt)
		end
			
		if not @posLen is null
		begin
			if LEN(@posSection) > 0
				set @posSection = @posSection + 'x' + convert(varchar, @posLen)
			else
				set @posSection = convert(varchar, @posLen)
		end
		
		if not @posDiam is null
		begin
			if not @posThick is null
				set @posSection = convert(varchar, @posDiam) + 'x' + convert(varchar, @posThick)
			else
				set @posSection = convert(varchar, @posDiam)
		end
		--===== section ====
		
		declare @var1 varchar(50)
		declare @var2 varchar(50)
		declare @var3 varchar(50)
		declare @var4 varchar(50)
		
		set @var1 = 'Окрашено'
		select @var2 = a.dicEng from parts.dbo.dictionary a where dicRus = @var1
		
		set @var3 = @partType
		select @var4 = a.dicEng from parts.dbo.dictionary a where dicRus = @var3
	
		insert @retPartsTable 
		select 
			@simID, 
			@elemID, 
			@pwDocID, 
			@partID, 
			@catID, 
			--'', 
			@num,
			@partCode, 
			@partName, 
			@var3 + CHAR(10) + @var4,
			@posSection, 
			@posMatName, -- + ' ' + @posStdNum, 
			@var1 + CHAR(10) + @var2,
			@pCentX,
			@pCentY,
			@pCentZ,
			@partDrawNum, 
			@partSupplier
	
		--=================================
		fetch next from c1 into 
			@simID, 
			@elemID, 
			@pwDocID, 
			@partCode, 
			@partDrawNum, 
			@partSupplier,
			@partName, 
			@partTypeID,
			@posThick1,
			@posThick2,
			@posThick3,
			@posThick4,
			@posDiam,
			@posWdt1,
			@posWdt2,
			@posLen,
			@posMatName,
			@posStdNum,
			@partID,
			@pCentX,
			@pCentY,
			@pCentZ
	end
	
	close c1
	deallocate c1
	
	
	
	
	RETURN 
END

--select * from dbo.func_i_FH1_EmbPart(0, 3, 19466) where pwdocid=125








GO
