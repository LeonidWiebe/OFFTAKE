SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[goofftall4]
(
	-- Add the parameters for the function here
	@listRowID bigint,
	@listRowObjID bigint,
	@listRowQty real,
	@maxMassLevel int,
	@pass int
)
RETURNS 
@retOfftTable TABLE 
(
	-- Add the column definitions for the TABLE variable here
	partdefID bigint, 
	srtmID bigint,
	matID bigint,
	mass real,
	qty real
)
AS
BEGIN
	declare @partdefID bigint = 0
	declare @srtmID bigint = 0
	declare @matID bigint = 0
	declare @mass real = 0.
	declare @qty real = 0.
	
	declare @mlev int = 0
	declare @partID bigint = 0
	declare @objID bigint = 0
	declare @partQty real = 0.
	declare @ispass int = 0
	
	if @listRowID = 0 RETURN
	
	if @listRowObjID = 1
	begin
	
		declare c1 cursor read_only for 
		select p.posCommonMass, p.srtmID, p.matID, p.posQuantity, pd.massLevel from position p 
		INNER JOIN
        dbo.sortament ON p.srtmID = dbo.sortament.srtmID 
        INNER JOIN
        dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
        INNER JOIN
        dbo.posdef pd ON dbo.r_standard_posdef.posdefID = pd.posdefID
		where p.partID = @listRowID

		select @partdefID = p.partdefID from part p where p.partID = @listRowID

		open c1
				
		fetch next from c1 into @mass, @srtmID, @matID, @qty, @mlev
		
		while @@FETCH_STATUS = 0
		begin
		
			if @matID is null set @matID = 0
		
			if @srtmID > 0
			begin
				if @mlev <= @maxMassLevel
				begin
					insert @retOfftTable 
					select @partdefID, @srtmID, @matID, @mass * @listRowQty, @qty * @listRowQty
				end
			end
			else if @srtmID < 0
			begin
				insert @retOfftTable 
				select * from dbo.goofftall4(-@srtmID, 1, @qty * @listRowQty, @maxMassLevel, @pass)
			end
		
			fetch next from c1 into @mass, @srtmID, @matID, @qty, @mlev
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
			select * from dbo.goofftall4(@partID, 1, @listRowQty, @maxMassLevel, @pass)
	
			fetch next from c1 into @partID
		end
		
		close c1
		deallocate c1
	
	end
	else if @listRowObjID = 14 -- catlist
	begin
	
		if @pass = -1 -- не определено, смотрим настройку
			select @ispass = abs(convert(int,p.clPassive)) from catlist p where p.catlistID = @listRowID
		else
			set @ispass = @pass -- пришло параметром
		
		
		if @ispass = 1
		begin
		
			declare c1 cursor read_only for select 
					p.partdefID, 
					p.srtmID, 
					p.matID, 
					p.mass, 
					p.qty
				from offtable p 
				where p.objID = @listRowObjID and p.objectID = @listRowID
		
			open c1
		
			fetch next from c1 into @partdefID, @srtmID, @matID, @mass, @qty
			
			while @@FETCH_STATUS = 0
			begin
		
				insert @retOfftTable 
				select @partdefID, @srtmID, @matID, @mass * @listRowQty, @qty * @listRowQty
			
				fetch next from c1 into @partdefID, @srtmID, @matID, @mass, @qty
			end
			
			close c1
			deallocate c1
		
		end
		else
		begin 
		
			declare c1 cursor read_only for select p.partID, p.objID, p.partQty from r_catlist_part p where p.catlistID = @listRowID
		
			open c1
					
			fetch next from c1 into @partID, @objID, @partQty
			
			while @@FETCH_STATUS = 0
			begin
			

				insert @retOfftTable 
				select * from dbo.goofftall4(@partID, @objID, @listRowQty * @partQty, @maxMassLevel, @ispass)
		
				fetch next from c1 into @partID, @objID, @partQty
			end
			
			close c1
			deallocate c1
			
		end
		
		
	
	
	
	end
	
	
	
	
	
	RETURN 
END

--select * from parts_bkp.dbo.goofftall4(1188, 14, 1, 1, -1)


GO
