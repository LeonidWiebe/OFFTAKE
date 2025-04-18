SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	функция для расчета выборки для чтроителей, версия 2, исп начиная с версии 2.7.10
-- =============================================
CREATE FUNCTION [dbo].[goofftall4_3]
(
	-- Add the parameters for the function here
	@listRowID bigint,
	@listRowObjID bigint,
	@listRowQty real,
	@maxMassLevel int,
	@pass int,
	@koef real
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
	declare @koeflist real = 1.
	declare @koefpos real = 1.
	
	declare @posnum int = 0
	declare @mlev int = 0
	declare @posID bigint = 0
	declare @partID bigint = 0
	declare @objID bigint = 0
	declare @partQty real = 0.
	declare @ispass int = 0
	
	if @listRowID = 0 RETURN
	
	if @listRowObjID = 1 -- PART
	begin
	
		declare c1 cursor read_only for 
		select p.posCommonMass, p.srtmID, p.matID, p.posQuantity, pd.massLevel, p.posNumber
		from position p 
		INNER JOIN dbo.sortament ON p.srtmID = dbo.sortament.srtmID 
        INNER JOIN dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
        INNER JOIN dbo.posdef pd ON dbo.r_standard_posdef.posdefID = pd.posdefID
		where p.partID = @listRowID

		select @partdefID = p.partdefID from part p where p.partID = @listRowID

		open c1
				
		fetch next from c1 into @mass, @srtmID, @matID, @qty, @mlev, @posnum
		
		while @@FETCH_STATUS = 0
		begin
		
			if @matID is null set @matID = 0

			-- корректировка массы для первой позиции если идет расчет массы по параметрам из имени изднлия
			-- с версии 2.7.10 не исп.
			if @posnum = 1 set @mass = @mass * @koef
		
			if @srtmID > 0
			begin
				if @mlev <= @maxMassLevel
				begin
					insert @retOfftTable 
					select @partdefID, @srtmID, @matID, @mass * @listRowQty, @qty * @listRowQty
				end
			end
			else if @srtmID < 0 -- ЭТО ЕСЛИ В ПОЗИЦИИ СИДИТ ИЗДЕЛИЕ -> @srtmID = -partID
			begin
				insert @retOfftTable 
				select * from dbo.goofftall4_3(-@srtmID, 1, @qty * @listRowQty, @maxMassLevel, @pass, @koef)
			end
		
			fetch next from c1 into @mass, @srtmID, @matID, @qty, @mlev, @posnum
		end
		
		close c1
		deallocate c1

	end
	else if @listRowObjID = 2 -- position (from v2.7.10)
	begin

		select 
		@mass = p.posCommonMass, 
		@srtmID = p.srtmID, 
		@matID = p.matID, 
		@qty = p.posQuantity, 
		@mlev = pd.massLevel, 
		@posnum = p.posNumber,
		@partdefID = prt.partdefID
		from position p 
		INNER JOIN dbo.sortament ON p.srtmID = dbo.sortament.srtmID 
        INNER JOIN dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
        INNER JOIN dbo.posdef pd ON dbo.r_standard_posdef.posdefID = pd.posdefID
        INNER JOIN dbo.part prt ON p.partID = prt.partID
		where p.posID = @listRowID

		if @matID is null set @matID = 0

		set @mass = @mass * @koef

		if @srtmID > 0
		begin
			--if @mlev <= @maxMassLevel
			--begin
				insert @retOfftTable 
				select @partdefID, @srtmID, @matID, @mass * @listRowQty, @qty * @listRowQty
			--end
		end
		else if @srtmID < 0 -- ЭТО ЕСЛИ В ПОЗИЦИИ СИДИТ ИЗДЕЛИЕ
		begin
			insert @retOfftTable 
			select * from dbo.goofftall4_3(-@srtmID, 1, @qty * @listRowQty, @maxMassLevel, @pass, @koef)
		end

	end
	else if @listRowObjID = 7 -- catalog
	begin
	
		declare c1 cursor read_only for select p.partID from part p where p.catID = @listRowID and p.deleted = 0
	
		open c1
				
		fetch next from c1 into @partID
		
		while @@FETCH_STATUS = 0
		begin
			insert @retOfftTable 
			select * from dbo.goofftall4_3(@partID, 1, @listRowQty, @maxMassLevel, @pass, @koef)
	
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
		
			declare c1 cursor read_only for 
				select p.partID, p.objID, p.partQty, p.koef, pos.posNumber, pos.koef
				from r_catlist_part p 
				LEFT OUTER JOIN r_catlist_position pos ON p.relID = pos.clpID
				where p.catlistID = @listRowID
		
			open c1
					
			fetch next from c1 into @partID, @objID, @partQty, @koeflist, @posnum, @koefpos
			
			while @@FETCH_STATUS = 0
			begin
			
				if @posnum is null -- no positions for list record
				begin

					insert @retOfftTable 
					select * from dbo.goofftall4_3(@partID, @objID, @listRowQty * @partQty, @maxMassLevel, @ispass, @koeflist)

				end
				else
				begin

					select @posID = p.posID from position p where p.partID = @partID and p.posNumber = @posnum

					insert @retOfftTable 
					select * from dbo.goofftall4_3(@posID, 2, @listRowQty * @partQty, @maxMassLevel, @ispass, @koefpos)

				end



		
				fetch next from c1 into @partID, @objID, @partQty, @koeflist, @posnum, @koefpos
			end
			
			close c1
			deallocate c1
			
		end
	
	end
	
	
	
	RETURN 
END

--select * from parts_bkp.dbo.goofftall4_3(21385, 14, 1, 1, 0, 1.)

/*
SELECT partdefID, srtmID, matID, sum(mass) as mass, sum(qty) as qty FROM parts.dbo.goofftall4_3(22090,14,1,1,-1,1) group by partdefID, srtmID, matID
SELECT* FROM parts.dbo.goofftall4_3(22090,14,1,1,-1,1)
*/

/*
SELECT partdefID, srtmID, matID, sum(mass) as mass, sum(qty) as qty 
SELECT *
FROM parts_bkp.dbo.goofftall4_3(21383,14,1,1,-1) 
group by partdefID, srtmID, matID
*/

/*
		select 
		p.posCommonMass, 
		p.srtmID, 
		p.matID, 
		p.posQuantity, 
		pd.massLevel, 
		p.posNumber
		from position p 
		INNER JOIN dbo.sortament ON p.srtmID = dbo.sortament.srtmID 
        INNER JOIN dbo.r_standard_posdef ON dbo.sortament.stdposdefID = dbo.r_standard_posdef.relID 
        INNER JOIN dbo.posdef pd ON dbo.r_standard_posdef.posdefID = pd.posdefID
		where p.partID = 1027517


				select p.partnameover, p.catlistid, p.partID, p.objID, p.partQty, p.koef, pos.posNumber, pos.koef
				from r_catlist_part p 
				LEFT OUTER JOIN r_catlist_position pos ON p.relID = pos.clpID
				where p.partID = 1027517



	*/

GO
