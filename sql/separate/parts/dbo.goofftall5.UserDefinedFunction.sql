SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[goofftall5]
(
	-- Add the parameters for the function here
	@listRowID bigint,
	@listRowObjID bigint,
	@listRowQty real
)
RETURNS 
@retOfftTable TABLE 
(
	-- Add the column definitions for the TABLE variable here
	kks varchar(50), 
	partdefID bigint, 
	srtmID bigint,
	matID bigint,
	mass real,
	qty real,
	mu varchar(5)
)
AS
BEGIN
	declare @partdefID bigint = 0
	declare @srtmID bigint = 0
	declare @posID bigint = 0
	declare @matID bigint = 0
	declare @mass real = 0.
	declare @qty real = 0.
	declare @pnum bigint = 0
	
	declare @partID bigint = 0
	declare @objID bigint = 0
	declare @partQty real = 0.
	declare @kks varchar(50) = ''
	declare @mu varchar(5) = ''
	
	declare @poslen real = 0.
	declare @poswdt real = 0.
	
	if @listRowID = 0 RETURN
	
	if @listRowObjID = 1
	begin
	
		declare c1 cursor read_only for 
		select 
		p.posID, p.posNumber, p.posCommonMass, p.srtmID, p.matID, p.posQuantity, pr.length, pr.width
		from 
		position p 
		left outer join r_position_property pr
		on p.posID = pr.posID 
		where p.partID = @listRowID

		select @partdefID = p.partdefID from part p where p.partID = @listRowID

		open c1
				
		fetch next from c1 into @posID, @pnum, @mass, @srtmID, @matID, @qty, @poslen, @poswdt
		
		while @@FETCH_STATUS = 0
		begin
		
			if @matID is null set @matID = 0
			
			set @mu = 'шт'
			
			if @poslen is not null and @poswdt is null 
			begin
			set @qty = @poslen * 1e-3 * @qty
			set @mu = 'м'
			end
			
			if @poslen is not null and @poswdt is not null 
			begin
			set @qty = @poslen * @poswdt * 1e-6 * @qty
			set @mu = 'м2'
			end
		
			if @srtmID > 0
			begin
			
				if @pnum = 1 set @kks = dbo.partkks(@listRowID) else set @kks = ''
			
				insert @retOfftTable
				select @kks, @partdefID, @srtmID, @matID, @mass * @listRowQty, @qty * @listRowQty, @mu
			end
			else if @srtmID < 0
			begin
				insert @retOfftTable 
				select * from dbo.goofftall5(-@srtmID, 1, @qty * @listRowQty)
			end
		
			fetch next from c1 into @posID, @pnum, @mass, @srtmID, @matID, @qty, @poslen, @poswdt
		end
		
		close c1
		deallocate c1

	end
	else if @listRowObjID = 7 -- catalog
	begin
	
		declare c1 cursor read_only for select p.partID from part p where p.catID = @listRowID and p.deleted = 0
	
		open c1
				
		fetch next from c1 into @partID
		
		while @@FETCH_STATUS = 0
		begin
			insert @retOfftTable 
			select * from dbo.goofftall5(@partID, 1, @listRowQty)
	
			fetch next from c1 into @partID
		end
		
		close c1
		deallocate c1
	
	end
	else if @listRowObjID = 14 -- catlist
	begin
	
		declare c1 cursor read_only for select p.partID, p.objID, p.partQty from r_catlist_part p where p.catlistID = @listRowID
	
		open c1
				
		fetch next from c1 into @partID, @objID, @partQty
		
		while @@FETCH_STATUS = 0
		begin
			insert @retOfftTable 
			select * from dbo.goofftall5(@partID, @objID, @listRowQty * @partQty)
	
			fetch next from c1 into @partID, @objID, @partQty
		end
		
		close c1
		deallocate c1
	
	end
	
	
	
	
	
	RETURN 
END

--select SUM(mass) from dbo.goofftall5(3971, 14, 1)




GO
