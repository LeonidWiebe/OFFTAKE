SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Vibe
-- Create date: 4/02/2021
-- Description:	таблица пожарных отсеков с параметрами для проекта FH1
-- =============================================
CREATE FUNCTION [dbo].[func_i_FireCompartment3]
(
	--@pwDocID bigint,
	--@pdsID bigint,
	--@catID bigint
)
RETURNS 
@retFireCompTable TABLE 
(
	bldID bigint,
	pwDocID bigint,
	fcID bigint,
	[fc code] nvarchar(max),
	[fc res] nvarchar(max),
	[fc res man] bigint,
	[area] real,
	[area man] real,
	[min floor] bigint,
	[max ceil] bigint,
	[f loads] nvarchar(max),
	[f haz class] nvarchar(max),
	[av of AFES] nvarchar(max),
	[rooms] nvarchar(max),
	[bld height] bigint,
	[bld f class] nvarchar(max),
	[fcFireLoadID] nvarchar(max)
)
AS
BEGIN


	declare @elemID bigint = 0
	declare @bldID bigint = 0
	declare @bldIDprev bigint = -1
	declare @pwDocID bigint = 0
	declare @pwDocIDprev bigint = 0
	declare @area real = 0.
	declare @areas real = 0.
	declare @areaman real = 0.
	declare @areamanprev real = 0.
	
	declare @fcID bigint = 0
	declare @fcIDPrev bigint = 0
	declare @fcCode nvarchar(max)
	declare @fcCodePrev nvarchar(max)

	declare @fcResFixed bigint = 0 -- значение FireResistance в таблице o_FireComp
	declare @fcResFixedPrev bigint = 0

	declare @fcCodeResist nvarchar(max)=''
	
	declare @roomCodes nvarchar(max)
	declare @roomCode nvarchar(max)
	--declare @roomCodePrev nvarchar(max)
	
	declare @roomFHClass nvarchar(max)
	declare @roomFHClasses nvarchar(max)
	--declare @roomFHClassPrev nvarchar(max)
	
	declare @roomFLoad nvarchar(max)
	declare @roomFLoads nvarchar(max)
	declare @fcFireLoad nvarchar(max)
	declare @fcFireLoads nvarchar(max)
	
	--declare @roomAAFESi int -- from aecosim base
	declare @roomAAFES nvarchar(max)
	declare @roomAAFESs nvarchar(max)
	--declare @roomAAFESprev nvarchar(max)
	
	declare @bldFClass nvarchar(max)
	declare @bldFClassPrev nvarchar(max)
	
	declare @bldmax bigint
	declare @bldmaxprev bigint
	declare @maxZ bigint
	declare @minZ bigint
	declare @maxZs bigint
	declare @minZs bigint

	declare c1 cursor read_only for 
		select 
			dd.bldID,
			e.pwdocID,								-- any
			e.pMaxZ,								-- max
			e.pMinZ,								-- min
			s.number kks,							-- list
			isnull(s.SPF_FireHazardClass,'') fhc,	-- list
			--isnull(s.SPF_FireLoadGroup,''),			-- list
			isnull(d.fire_load,''),			-- list
			isnull(f.fcID,0) fcID,
			isnull(f.fcFireRes,0) fcResFixed,
			isnull(f.fcCode,'') fcCode,
			isnull(b.bldFireClass,''),
			isnull(b.bldHeight,0),
			isnull(d.autp_avl,'') AFES,			-- list
			--s.Doc2_autp_avl AFES,				    -- list
			dbo.getTrueArea2(e.simID, 0, 2),
			isnull(f.fcFloorArea,0) fcArea,
			isnull(f.fcFireLoad,'') fload
		FROM    dbo.elements e  
		INNER JOIN dbo.i_Space s ON s.simID = e.simID
		INNER JOIN dbo.o_FireComp f ON f.fcID = s.fcID
		INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON e.pwdocID = dd.id
		LEFT OUTER JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS d ON s.simID = d.simID
		LEFT OUTER JOIN dbo.o_Building b ON dd.bldID = b.pwFolderID
		order by fcCode, kks

	open c1
	
	fetch next from c1 into 
		@bldID,
		@pwDocID,
		@maxZ,
		@minZ,
		@roomCode,
		@roomFHClass,
		@roomFLoad,
		@fcID,
		@fcResFixed,
		@fcCode,
		@bldFClass,
		@bldmax,
		@roomAAFES, -- @roomAAFESi
		@area,
		@areaman,
		@fcFireLoad

	while @@FETCH_STATUS = 0
	begin
		--=================================
		
		--if @fcCode is null goto cont
		if len(@fcCode)=0  goto cont
		
		
		if CHARINDEX('less', @roomFLoad) > 0 -- possible values <600, < 600
			set @roomFLoad = '<'
		else if CHARINDEX('over', @roomFLoad) > 0  -- possible values >1200, > 1200
			set @roomFLoad = '>'
		else if CHARINDEX('from', @roomFLoad) > 0
			set @roomFLoad = '='
		else if LEFT(@roomFLoad, 1) = '<'
			set @roomFLoad = '<'
		else if LEFT(@roomFLoad, 1) = '>'
			set @roomFLoad = '>'
		else if CHARINDEX('-', @roomFLoad) > 0
			set @roomFLoad = '='
		else
			set @roomFLoad = '?'
		
		/*
		if @roomAAFESi > 0 
			set @roomAAFES = '+'
		else if @roomAAFESi < 0 
			set @roomAAFES = '-'
		else
			set @roomAAFES = '?'
		*/
		if CHARINDEX('yes', @roomAAFES) > 0 -- possible values <600, < 600
			set @roomAAFES = '+'
		else if CHARINDEX('no', @roomAAFES) > 0  -- possible values >1200, > 1200
			set @roomAAFES = '-'
		else
			set @roomAAFES = '?'
		
		
		--if @bldIDprev != @bldID
		--begin
		--	select @bldmax = MAX(pMaxZ) from elements where elements.bldID = @bldID
		--end

		
		if @fcCodePrev is null -- first row
		begin
			set @roomCodes = @roomCode
			set @roomFLoads = @roomFLoad
			set @fcFireLoads = @fcFireLoad
			set @roomFHClasses = @roomFHClass
			set @roomAAFESs = @roomAAFES
			set @areas = @area
			set @maxZs = @maxZ
			set @minZs = @minZ
			
		end
		else if @fcCode != @fcCodePrev
		begin
			
			insert @retFireCompTable select 
				@bldIDprev,
				@pwDocIDprev, 
				@fcIDPrev,
				@fcCodePrev, 
				@fcCodeResist,
				@fcResFixedPrev,
				round(@areas,2), 
				round(@areamanprev,2),
				@minZs, 
				@maxZs, 
				@roomFLoads, 
				@roomFHClasses,
				@roomAAFESs, 
				@roomCodes, 
				@bldmaxprev, 
				@bldFClassPrev,
				@fcFireLoads
			
			set @roomCodes = @roomCode
			set @roomFLoads = @roomFLoad
			set @fcFireLoads = @fcFireLoad
			set @roomFHClasses = @roomFHClass
			set @roomAAFESs = @roomAAFES
			set @areas = @area
			set @maxZs = @maxZ
			set @minZs = @minZ
		end
		else
		begin
			set @roomCodes = @roomCodes + ',' + @roomCode
			set @roomFLoads = @roomFLoads + ' ' + @roomFLoad
			set @fcFireLoads = @fcFireLoads + ' ' + @fcFireLoad
			set @roomFHClasses = @roomFHClasses + ' ' + @roomFHClass
			set @roomAAFESs = @roomAAFESs + ' ' + @roomAAFES
			set @areas = @areas + @area
			if @maxZs < @maxZ set @maxZs = @maxZs + @maxZ
			if @minZs > @minZ set @minZs = @minZs - @minZ
		end
		
		set @pwDocIDprev = @pwDocID
		set @fcIDPrev = @fcID
		set @fcResFixedPrev = @fcResFixed
		set @fcCodePrev = @fcCode
		--set @roomAAFESprev = @roomAAFES
		if @bldmax!=0 set @bldmaxprev = @bldmax
		set @bldIDprev = @bldID
		if len(@bldFClass)>0 set @bldFClassPrev = @bldFClass
		--set @roomFHClassPrev = @roomFHClass
		set @areamanprev = @areaman

		set @fcCodeResist = [dbo].[getFireResistance](
			@bldFClassPrev, --@bld_fire_class nvarchar (max),
			@roomFHClasses, --@room_fire_hazard_class nvarchar (max),
			@roomFLoads, --@room_fire_load nvarchar (max),
			@roomAAFESs, --@room_av_afes nvarchar (max),
			@minZs, --@fc_lev_min bigint, -- in mm
			@maxZs, --@fc_lev_max bigint, -- in mm
			@bldmaxprev --@bld_height bigint -- in mm
		)
		
cont:
		--=================================
		fetch next from c1 into 
			@bldID,
			@pwDocID,
			@maxZ,
			@minZ,
			@roomCode,
			@roomFHClass,
			@roomFLoad,
			@fcID,
			@fcResFixed,
			@fcCode,
			@bldFClass,
			@bldmax,
			@roomAAFES,--@roomAAFESi
			@area,
			@areaman,
			@fcFireLoad
	end
	
	
	close c1
	deallocate c1
	
	
	if len(@fcCode)>0 insert @retFireCompTable select 
				@bldIDprev,
				@pwDocIDprev,
				@fcIDPrev, 
				@fcCodePrev, 
				@fcCodeResist,
				@fcResFixedPrev,
				round(@areas,2),
				round(@areamanprev,2),
				@minZs, 
				@maxZs, 
				@roomFLoads, 
				@roomFHClasses,
				@roomAAFESs, 
				@roomCodes, 
				@bldmaxprev, 
				@bldFClassPrev,
				@fcFireLoads
	
	
	RETURN 
END

--select * from dbo.[func_i_FireCompartment3]() where bldid=685
/*
Select * from func_i_FireCompartment3() where pwdocID in (2664,46,2288,2287,2665,47,2290,2291,8130,2666,48,2293,2292,3108,49,2294,2295,50,2296,2297,3109,51,2299,2298,3110,240,2301,2300,3111,14876,457,2302,2155,3112,242,2303,3113,5538,52,2305,2304,5544,54,53,2306,2307,10813,2309,2308,5541,5542,4904,4905,4906,5543,126,15125,15176,15177,101,15126,15127,15152,15153,15154,15167,15168,15169,15171,15173,15172,114,15124,15178,15179,15180,15181,15160,15161,478,13052,16347,15174,15175,16348,3696,442,13941,14019,14020,14024,14494,14493,14496,14495,14497,14498,14586,14500)

UKC
Select * from func_i_FireCompartment3() where pwdocID in (3331,3332,3333,3335,3336,987,211,985,988,983,994,992,990,212,991,998,997,999,213,1000,1003,1002,1006,214,1007,1010,1008,1012,215,1839,1014,1015,216,1845,16531,1018,1019,1822,1846,2788,2789,984,2538,2539,16488,16489,16490,16491,16500,12899,16486,12897,12896,16537,12895,12894,16534,12893,12892,16535,12891,12890,12889,12888,16536,12887,12886,12885,12884,12883,12882,16484,16485,16533,14501)


11USG
Select * from view_i_FH1_W_FireCompRoom where pwdocID in (476,1567,1568,1565,2904,16689,475,1606,1607,2541,14651,1594,13576,13577,6069,13899,13578,13579,4872,14060,13580,13581,16482,16487) order by [room code]
Select * from func_i_FireCompartment3() where pwdocID in (476,1567,1568,1565,2904,16689,475,1606,1607,2541,14651,1594,13576,13577,6069,13899,13578,13579,4872,14060,13580,13581,16482,16487)

*/

/*
		select 
			dd.bldID,
			e.pwdocID,								-- any
			e.pMaxZ,								-- max
			e.pMinZ,								-- min
			s.number kks,							-- list
			isnull(s.SPF_FireHazardClass,'') fhc,	-- list
			isnull(s.SPF_FireLoadGroup,''),			-- list
			isnull(f.fcID,0) fcID,
			isnull(f.fcFireRes,0) fcResFixed,
			isnull(s.NumFireComp,'') fcCode,
			isnull(b.bldFireClass,''),
			isnull(b.bldHeight,0),
			isnull(d.autp_avl,'') AFES,				-- list
			dbo.getTrueArea2(e.simID, 0, 1)
		FROM    dbo.elements e  
		INNER JOIN dbo.i_Space s ON s.simID = e.simID
		LEFT OUTER JOIN dbo.o_FireComp f ON f.fcCode = s.NumFireComp
		INNER JOIN [PW-SRV.SP.SPBAEP.RU].[pw_aep].[dbo].[view_docdata_all] AS dd ON e.pwdocID = dd.id
		LEFT OUTER JOIN [10.36.69.19].[HHKV_1].[dbo].[room_charact] AS d ON s.simID = d.simID
		--LEFT JOIN [10.36.69.19].[HHKV_1].[dbo].[bld_charact] AS b ON LEFT(s.number,5)=b.[bld_kks]
		LEFT OUTER JOIN dbo.o_Building b ON e.bldID = b.pwFolderID
		where e.pwdocID in (2664,46,2288,2287,2665,47,2290,2291,8130,2666,48,2293,2292,3108,49,2294,2295,50,2296,2297,3109,51,2299,2298,3110,240,2301,2300,3111,14876,457,2302,2155,3112,242,2303,3113,5538,52,2305,2304,5544,54,53,2306,2307,10813,2309,2308,5541,5542,4904,4905,4906,5543,126,15125,15176,15177,101,15126,15127,15152,15153,15154,15167,15168,15169,15171,15173,15172,114,15124,15178,15179,15180,15181,15160,15161,478,13052,16347,15174,15175,16348,3696,442,13941,14019,14020,14024,14494,14493,14496,14495,14497,14498,14586,14500)
		order by fcCode, kks


*/






GO
