SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[func_i_EmbPartLoad]
(
	@res1 bigint,
	@res2 bigint,
	@res3 varchar(100),
	@res4 varchar(100)
)
RETURNS 
@retPartsTable TABLE 
(
	simID bigint,
	elemID bigint,
	pwDocID bigint,
	[Speciality] varchar(50),
	[HighMark] bigint,
	[PartIdentNumber] bigint,
	[PartIdentCode] varchar(150),
    [NuclearSafetyClass] varchar(50),
    [SeismicClass]	varchar(50),
    [CatalogName] varchar(50),
    [PartCode] varchar(50),
    [Section] varchar(50),
    [Material] varchar(150),
    [Q{1}] real,
    [FX{1}] real,
    [FY{1}] real,
    [FZ{1}] real,
    [MX{1}] real,
    [MY{1}] real,
    [MZ{1}] real,
    [Q{2}] real,
    [FX{2}] real,
    [FY{2}] real,
    [FZ{2}] real,
    [MX{2}] real,
    [MY{2}] real,
    [MZ{2}] real,
    [Q{3}] real,
    [FX{3}] real,
    [FY{3}] real,
    [FZ{3}] real,
    [MX{3}] real,
    [MY{3}] real,
    [MZ{3}] real,
    [Q{4}] real,
    [FX{4}] real,
    [FY{4}] real,
    [FZ{4}] real,
    [MX{4}] real,
    [MY{4}] real,
    [MZ{4}] real
)
AS
BEGIN


	declare @simID bigint = 0
	declare @simsimID bigint = 0
	declare @elemID bigint = 0
	declare @pwDocID bigint = 0

	declare @cattype varchar(200)
	
	declare @HighMark bigint = 0
	declare @PartIdentNumber bigint = 0
	
	declare @CatalogName varchar(50)
	declare @Material varchar(50)
	declare @PartCode varchar(50)
	declare @NuclearSafetyClass varchar(50)
	declare @SeismicClass varchar(50)
	declare @Speciality varchar(50)
	declare @PartIdentCode varchar(450)
	
	declare @Width real;
	declare @Thickness real;
	
	declare @pCentX bigint;
	declare @pCentY bigint;
	declare @pCentZ bigint;
	
	declare @pMinX bigint;
	declare @pMinY bigint;
	declare @pMinZ bigint;
	
	declare @pMaxX bigint;
	declare @pMaxY bigint;
	declare @pMaxZ bigint;
	
	declare @gap bigint = 10;
	declare @cnt bigint = 0;
	
	declare @Q1 real;
	declare @Q2 real;
	declare @Q3 real;
	declare @Q4 real;
	
	declare @FX1 real;
	declare @FX2 real;
	declare @FX3 real;
	declare @FX4 real;
	
	declare @FY1 real;
	declare @FY2 real;
	declare @FY3 real;
	declare @FY4 real;
	
	declare @FZ1 real;
	declare @FZ2 real;
	declare @FZ3 real;
	declare @FZ4 real;
	
	declare @MX1 real;
	declare @MX2 real;
	declare @MX3 real;
	declare @MX4 real;
	
	declare @MY1 real;
	declare @MY2 real;
	declare @MY3 real;
	declare @MY4 real;
	
	declare @MZ1 real;
	declare @MZ2 real;
	declare @MZ3 real;
	declare @MZ4 real;
	
	
	
	
	declare c1 cursor read_only for 
		SELECT 
		p.simID,
		p.elemID,
		p.pwdocID,
		p.cattype,
		p.pMinX,
		p.pMinY,
		p.pMinZ,
		p.pMaxX,
		p.pMaxY,
		p.pMaxZ
		FROM [dbo].[elements] p  where cattype='EmbPlateProfile' or cattype='EmbeddedPart'



	open c1
	
	fetch next from c1 into 
		@simID, 
		@elemID, 
		@pwDocID, 
		@cattype,
		@pMinX,
		@pMinY,
		@pMinZ,
		@pMaxX,
		@pMaxY,
		@pMaxZ
	
	while @@FETCH_STATUS = 0
	begin
	
		SELECT 
		@CatalogName = p.CatalogName,
		@HighMark = p.HighMark,
		@Material = p.Material,
		@NuclearSafetyClass = p.NuclearSafetyClass,
		@PartCode = p.PartCode,
		@PartIdentCode = p.PartIdentCode,
		@PartIdentNumber = p.PartIdentNumber,
		@SeismicClass = p.SeismicClass,
		@Speciality = p.Speciality
		FROM [dbo].[i_EmbPart] p where simID = @simID
		
		set @cnt = 0
		
		---------------------------------------
		
		if @cattype = 'EmbPlateProfile'
		begin
		
			SELECT 
			@Width = p.Width,
			@Thickness = p.Thickness
			FROM [dbo].[i_EmbPlate] p where simID = @simID
			
			---- нагрузки ---
			
			declare c2 cursor read_only for 
				SELECT 
				p.simID
				FROM [dbo].[elements] p  where cattype='EmbPlateLoad' 
				and pCentX between (@pMinX - @gap) and (@pMaxX + @gap)
				and pCentY between (@pMinY - @gap) and (@pMaxY + @gap)
				and pCentZ between (@pMinZ - @gap) and (@pMaxZ + @gap)
			
			open c2
			
			fetch next from c2 into 
				@simsimID
			
			while @@FETCH_STATUS = 0 and @cnt < 10
			begin
			
				SELECT 
				@Q1 = p.Q,
				@FX1 = p.FX,
				@FY1 = p.FY,
				@FZ1 = p.FZ,
				@MX1 = p.MX,
				@MY1 = p.MY,
				@MZ1 = p.MZ
				FROM [dbo].[i_EmbLoadA] p where simID = @simsimID
			
				SELECT 
				@Q2 = p.Q,
				@FX2 = p.FX,
				@FY2 = p.FY,
				@FZ2 = p.FZ,
				@MX2 = p.MX,
				@MY2 = p.MY,
				@MZ2 = p.MZ
				FROM [dbo].[i_EmbLoadB] p where simID = @simsimID
			
				SELECT 
				@Q3 = p.Q,
				@FX3 = p.FX,
				@FY3 = p.FY,
				@FZ3 = p.FZ,
				@MX3 = p.MX,
				@MY3 = p.MY,
				@MZ3 = p.MZ
				FROM [dbo].[i_EmbLoadC] p where simID = @simsimID
			
				SELECT 
				@Q4 = p.Q,
				@FX4 = p.FX,
				@FY4 = p.FY,
				@FZ4 = p.FZ,
				@MX4 = p.MX,
				@MY4 = p.MY,
				@MZ4 = p.MZ
				FROM [dbo].[i_EmbLoadD] p where simID = @simsimID
			
			
				insert @retPartsTable 
				select 
					@simID,
					@elemID,
					@pwDocID,
					@Speciality,
					@HighMark,
					@PartIdentNumber,
					@PartIdentCode,
					@NuclearSafetyClass,
					@SeismicClass,
					@CatalogName,
					@PartCode,
					'', -- @Section,
					@Material,
					@Q1,
					@FX1,
					@FY1,
					@FZ1,
					@MX1,
					@MY1,
					@MZ1,
					@Q2,
					@FX2,
					@FY2,
					@FZ2,
					@MX2,
					@MY2,
					@MZ2,
					@Q3,
					@FX3,
					@FY3,
					@FZ3,
					@MX3,
					@MY3,
					@MZ3,
					@Q3,
					@FX3,
					@FY3,
					@FZ3,
					@MX3,
					@MY3,
					@MZ3
			
				set @cnt = @cnt + 1
			
				fetch next from c2 into 
					@simsimID
			end
			
			
			close c2
			deallocate c2
		
			
			
		end
		else
		begin
			set @Width = 0.0
			set @Thickness = 0.0
		end
	
		
		
		
		if @cnt = 0
		begin
			insert @retPartsTable 
			select 
				@simID,
				@elemID,
				@pwDocID,
				@Speciality,
				@HighMark,
				@PartIdentNumber,
				@PartIdentCode,
				@NuclearSafetyClass,
				@SeismicClass,
				@CatalogName,
				@PartCode,
				'', -- @Section,
				@Material,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL,
				NULL
		end
		
		
		-------------------------------------------------
	
		fetch next from c1 into 
			@simID, 
			@elemID, 
			@pwDocID, 
			@cattype,
			@pMinX,
			@pMinY,
			@pMinZ,
			@pMaxX,
			@pMaxY,
			@pMaxZ
	end
	
	close c1
	deallocate c1
	
	

	
	
	RETURN 
END

--select * from dbo.func_i_EmbPartLoad(0, 0, '','') where pwdocid=12204









GO
