SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[goOfftVed4]
(
	-- Add the parameters for the function here
	@listRowID bigint,
	@listRowObjID bigint,
	@listRowQty real,
	@prntcatID bigint, -- чтобы взять атрибут catdefID для унифицированных закладных
	@pass int
)
RETURNS 
@retOfftTable TABLE 
(
	-- Add the column definitions for the TABLE variable here
	levName varchar(250),
	catdefName varchar(250),
	partdefName varchar(250), 
	posdefName varchar(250), 
	matName varchar(250),
	mass real,
	qty real,
	matID bigint,
	posdefID bigint,
	catdefID bigint,
	levNum int
)
AS
BEGIN
	declare @posdefName varchar(250) = ''
	declare @partdefName varchar(250) = ''
	declare @levName varchar(250) = ''
	declare @srtmID bigint = 0
	declare @matID bigint = 0
	declare @matName varchar(250) = ''
	declare @mass real = 0.
	declare @qty real = 0.
	
	declare @mlev int = 0
	declare @levNum int = 0
	declare @partID bigint = 0
	declare @partdefID bigint = 0
	declare @posdefID bigint = 0
	declare @objID bigint = 0
	declare @partQty real = 0.
	declare @ispasscur int = 0
	declare @catID bigint = 0
	declare @catdefID bigint = 0
	declare @catdefName varchar(250) = ''
	
	if @listRowID = 0 RETURN
	
	
	
	
	if @listRowObjID = 14 -- catlist
	begin
	
		select @ispasscur = abs(convert(int,p.clPassive)), @catID = p.catID from catlist p where p.catlistID = @listRowID
	
		if @pass = 0 set @ispasscur = 0 -- принудительно без таблиц
		
		if @ispasscur = 1 -- каждый список отвечает за себя
		begin
		
			set @levnum = dbo.getLevNum(7, @catID) -- только из родительского каталога!
			set @levName = dbo.getLevel2(0, 0, @levnum)
			
			set @catdefID = dbo.getCatDefID(7, @catID) -- только из родительского каталога!
			set @catdefName = dbo.getCatDef2(0, 0, @catdefID)
		
			declare c1 cursor read_only for select p.partdefID, p.srtmID, p.matID, p.mass, p.qty from offtable p where p.objID = @listRowObjID and p.objectID = @listRowID
		
			open c1
					
			fetch next from c1 into @partdefID, @srtmID, @matID, @mass, @qty
			
			while @@FETCH_STATUS = 0
			begin
				
				select @partdefName = p.partdefNameMulti from partdef p where p.partdefID = @partdefID
				
				select 
					@posdefName = pd.posdefName,
					@posdefID = pd.posdefID
				from 
					dbo.sortament
				INNER JOIN
					dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
				INNER JOIN
					dbo.posdef pd ON dbo.r_standard_posdef.posdefID = pd.posdefID
				where 
					dbo.sortament.srtmID = @srtmID
					
				set @matName = ''
				if not (@matID is null or @matID = 0)
					select @matName = p.matName + ' ' + p.stdFullNumber from view_r_material_standard p where p.matID = @matID
				else
					set @matID = 0
		
				-- =============================
				insert @retOfftTable 
				select @levName, @catdefName, @partdefName, @posdefName, @matName, @mass * @listRowQty, @qty * @listRowQty, @matID, @posdefID, @catdefID, @levNum
				-- =============================
		
		
				fetch next from c1 into @partdefID, @srtmID, @matID, @mass, @qty
			end
			
			close c1
			deallocate c1
		
		end
		else -- считаем по честному
		begin
		
			
			declare c1 cursor read_only for select p.partID, p.objID, p.partQty from r_catlist_part p where p.catlistID = @listRowID
		
			open c1
					
			fetch next from c1 into @partID, @objID, @partQty
			
			while @@FETCH_STATUS = 0
			begin
			
				begin
					-- ----------------------------
					insert @retOfftTable 
					select * from dbo.goOfftVed4(@partID, @objID, @listRowQty * @partQty, @catID, @pass)
					-- ----------------------------
				end
		
				fetch next from c1 into @partID, @objID, @partQty
			end
			
			close c1
			deallocate c1
		
		end
	
	
	end
	else if @listRowObjID = 7 -- catalog
	begin
	
		set @catID = @listRowID
	
		declare c1 cursor read_only for select p.partID from part p where p.catID = @catID and p.deleted = 0
	
		open c1
				
		fetch next from c1 into @partID
		
		while @@FETCH_STATUS = 0
		begin
			-- ----------------------------
			insert @retOfftTable 
			select * from dbo.goOfftVed4(@partID, 1, @listRowQty, @catID, @pass)
			-- ----------------------------
	
			fetch next from c1 into @partID
		end
		
		close c1
		deallocate c1
	
	end
	else if @listRowObjID = 1 -- part
	begin
	
		set @partID = @listRowID
	
		select @partdefID = p.partdefID from part p where p.partID = @partID
		select @partdefName = p.partdefNameMulti from partdef p where p.partdefID = @partdefID
	
		set @levnum = dbo.getLevNum(7, @prntcatID)
		set @levName = dbo.getLevel2(0, 0, @levnum)
		
		set @catdefID = dbo.getCatDefID(7, @prntcatID)
		set @catdefName = dbo.getCatDef2(0, 0, @catdefID)

		declare c1 cursor read_only for 
		select 
			pd.posdefName,
			p.srtmID, 
			p.matID, 
			p.posCommonMass, 
			p.posQuantity,
			pd.posdefID
		from 
			position p 
		INNER JOIN
			dbo.sortament ON p.srtmID = dbo.sortament.srtmID 
        INNER JOIN
			dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
        INNER JOIN
			dbo.posdef pd ON dbo.r_standard_posdef.posdefID = pd.posdefID
		where 
			p.partID = @partID


		open c1
				
		fetch next from c1 into @posdefName, @srtmID, @matID, @mass, @qty, @posdefID
		
		while @@FETCH_STATUS = 0
		begin
		
			if @srtmID < 0
				-- ---------------------------------
				insert @retOfftTable 
				select * from dbo.goOfftVed4(-@srtmID, 1, @listRowQty, @prntcatID, @pass)
				-- ---------------------------------
			else
			begin
				
				set @matName = ''
				if not (@matID is null or @matID = 0)
					select @matName = p.matName + ' ' + p.stdFullNumber from view_r_material_standard p where p.matID = @matID
				else
					set @matID = 0
					
				-- =================================
				insert @retOfftTable 
				select @levName, @catdefName, @partdefName, @posdefName, @matName, @mass * @listRowQty, @qty * @listRowQty, @matID, @posdefID, @catdefID, @levNum
				-- =================================
			end
		
		
			fetch next from c1 into @posdefName, @srtmID, @matID, @mass, @qty, @posdefID
		end
		
		close c1
		deallocate c1

	end
	
	
	
	
	
	RETURN 
END

--select * from dbo.goOfftVed4(4967, 14, 1,0,-1)









GO
