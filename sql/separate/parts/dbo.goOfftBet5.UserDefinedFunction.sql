SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[goOfftBet5]
(
	-- Add the parameters for the function here
	@listRowID bigint,
	@listRowObjID bigint,
	@listRowQty real,
	@inclChildren bit
)
RETURNS 
@retOfftTable TABLE 
(
	-- Add the column definitions for the TABLE variable here
	lev varchar(250),
	catdef varchar(250),
	gamma varchar(250), 
	linear varchar(250), 
	class varchar(250),
	width varchar(50),
	qty real, -- volume
	aqty real, -- area
	srtmID bigint
)
AS
BEGIN
	declare @sthick varchar(50) = ''
	declare @srad varchar(50) = ''
	declare @posdefID bigint = 0
	declare @posdefName varchar(250) = ''
	declare @std varchar(250) = ''
	declare @srtm varchar(250) = ''
	declare @levName varchar(250) = ''
	declare @srtmID bigint = 0
	declare @matID bigint = 0
	declare @matName varchar(250) = ''
	declare @mass real = 0.
	declare @qty real = 0.
	declare @aqty real = 0. -- area q-ty added
	declare @thick real = 0.
	declare @rad real = 0.
	declare @glevel int = 0
	declare @secwdt real = 0.
	declare @sechgt real = 0.
	
	declare @catdefName varchar(250) = ''
	declare @partID bigint = 0
	declare @partdefID bigint = 0
	declare @objID bigint = 0
	declare @objectID bigint = 0
	declare @ispasscur int = 0
	declare @catID bigint = 0
	declare @posID bigint = 0
	
	if @listRowID = 0 RETURN
	
	
	
	
	if @listRowObjID = 14 -- catlist
	begin
	
		select @catID = p.catID from catlist p where p.catlistID = @listRowID
			
		-- ----------------------------
		--insert @retOfftTable 
		--select * from dbo.goOfftBet5(@catID, 7, @listRowQty)
		 ----------------------------
			
			
		declare c1 cursor read_only for select p.partID, p.objID, p.partQty from r_catlist_part p where p.catlistID = @listRowID
	
		open c1
				
		fetch next from c1 into @objectID, @objID, @qty
		
		while @@FETCH_STATUS = 0
		begin
		
			begin
				-- ----------------------------
				insert @retOfftTable 
				select * from dbo.goOfftBet5(@objectID, @objID, @listRowQty * @qty, @inclChildren)
				-- ----------------------------
			end
	
			fetch next from c1 into @objectID, @objID, @qty
		end
		
		close c1
		deallocate c1
	
	end
	else if @listRowObjID = 7 -- catalog
	begin
	
		set @catID = @listRowID
		
		set @levName = dbo.getLevel(7, @catID)
	
		declare c1 cursor read_only for 
		select p.srtmID, p.posQuantity, p.posID
		from catpos p 
		where p.partID = @catID
	
		open c1
				
		fetch next from c1 into @srtmID, @qty, @posID
		
		while @@FETCH_STATUS = 0
		begin
		
			select 
				@std = st.stdFullNumber,
				@srtm = dbo.sortament.srtmName,
				@posdefID = dbo.r_standard_posdef.posdefID
			from 
				dbo.sortament
			INNER JOIN
				dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
			INNER JOIN
				dbo.view_standard st ON dbo.r_standard_posdef.stdID = st.stdID
			where 
				dbo.sortament.srtmID = @srtmID
	
			if @posdefID = 96 -- бетон
			begin
				select 
				@thick = p.thickness
				, @rad = p.radiusinn
				, @glevel = p.glevel
				, @aqty = p.area 
				, @secwdt = p.width
				, @sechgt = p.height
				from r_catpos_property p 
				where p.posID = @posID
				
				if @secwdt > 0 and @sechgt > 0 set @sthick = CONVERT(varchar, @secwdt) + 'x' + CONVERT(varchar, @sechgt)
				else if @thick is null set @sthick = 'Без толщины' 
				else if @thick = 0 set @sthick = 'Без толщины' 
				else set @sthick = CONVERT(varchar, @thick)
				
				if @rad is null set @srad = 'Прямолинейная'
				else if @rad = 0 set @srad = 'Прямолинейная' 
				else set @srad = 'По радиусу'
				
				if not @glevel is null and @glevel != 0 set @levName = dbo.getLevel2(0, 0, @glevel)
			
				set @catdefName = dbo.getCatDef(19, @posID)
				
				if @aqty is null set @aqty = 0
			
				-- ========================================
				insert @retOfftTable 
				select @levName, @catdefName, @std, @srad, @srtm, @sthick, @qty * @listRowQty, @aqty * @listRowQty, @srtmID
				-- ========================================
			end
	
			fetch next from c1 into @srtmID, @qty, @posID
		end
		
		close c1
		deallocate c1
		
		--================================
		
		if @inclChildren != 0
		begin
		
			declare c2 cursor read_only for 
			select p.catalogID
			from r_object_catalog p 
			where p.objID = 7 and p.objectID = @catID
			
			open c2
			
			fetch next from c2 into @posID
			
			while @@FETCH_STATUS = 0
			begin
			
				-- ----------------------------
				insert @retOfftTable 
				select * from dbo.goOfftBet5(@posID, 7, @listRowQty, @inclChildren)
				-- ----------------------------
			
				fetch next from c2 into @posID
			end
			
			close c2
			deallocate c2
			
		end
	
	end
	else if @listRowObjID = 1 -- part
	begin
	
		set @partID = @listRowID
		
		set @levName = dbo.getLevel(1, @partID)
		set @catdefName = dbo.getCatDef(1, @partID)
	
		declare c1 cursor read_only for select p.srtmID, p.posQuantity, p.posID  from position p where p.partID = @catID
	
		open c1
				
		fetch next from c1 into @srtmID, @qty, @posID
		
		while @@FETCH_STATUS = 0
		begin
		
			select 
				@std = st.stdFullNumber,
				@srtm = dbo.sortament.srtmName,
				@posdefID = dbo.r_standard_posdef.posdefID
			from 
				dbo.sortament
			INNER JOIN
				dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
			INNER JOIN
				dbo.view_standard st ON dbo.r_standard_posdef.stdID = st.stdID
			where 
				dbo.sortament.srtmID = @srtmID
	
			if @posdefID = 96 -- бетон
			begin
				select @thick = p.thickness, @rad = p.radiusinn from r_position_property p where p.posID = @posID
				
				if @thick is null set @sthick = 'Без толщины' 
				else if @thick = 0 set @sthick = 'Без толщины' 
				else set @sthick = CONVERT(varchar, @thick)
				
				if @rad is null set @srad = 'Прямолинейная'
				else if @rad = 0 set @srad = 'Прямолинейная' 
				else set @srad = 'По радиусу'
			
				-- ========================================
				insert @retOfftTable 
				select @levName, @catdefName, @std, @srad, @srtm, @thick, @qty * @listRowQty, 0, @srtmID -- area in parts not calculated
				-- ========================================
			end
	
			fetch next from c1 into @srtmID, @qty, @posID
		end
		
		close c1
		deallocate c1
	

	end
	
	
	
	
	
	RETURN 
END

--select * from dbo.goOfftBet5(8484, 14, 1,0)














GO
