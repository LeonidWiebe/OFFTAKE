SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description: use in Offtake code in function updateStatusListMass()
-- =============================================
CREATE FUNCTION [dbo].[getPosCmnMass2]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @mass real = 0.;
	DECLARE @m_partID bigint = 0;
	DECLARE @m_posID bigint = 0;
	DECLARE @m_objID bigint = 0;
	DECLARE @m_qty real = 0.;
	--DECLARE @m_koef_part real = 1.;
	DECLARE @m_koef real = 1.;
	DECLARE @m_pnum int = 0;

	if @objID = 1 -- part
	begin
		select @mass = sum(p.posCommonMass) from position p where p.partID = @objectID
		if @mass is null set @mass = 0.
	end
	else if @objID = 2 -- pos
	begin
		select @mass = p.posCommonMass from position p where p.posID = @objectID
	end
	else if @objID = 7 -- cat
	begin
	
		declare c1 cursor read_only for select p.partID from part p where p.catID = @objectID and p.deleted = 0

		open c1
				
		fetch next from c1 into @m_partID
		
		while @@FETCH_STATUS = 0
		begin
			set @mass = @mass + dbo.getPosCmnMass2(1, @m_partID)
		
			fetch next from c1 into @m_partID
		end
		
		close c1
		deallocate c1
	
	end
	else if @objID = 14 -- catlist
	begin
	
		declare c1 cursor read_only for 
		select 
		p.partID, 
		p.objID, 
		p.partQty
		,pp.posNumber
		,pp.koef
		--,p.koef -- @m_koef_part --   коэффициент в списке, пока не используется, поэтому не включаем
		from r_catlist_part p 
		left outer join r_catlist_position pp on p.relID = pp.clpID
		where p.catlistID = @objectID

		open c1
				
		fetch next from c1 into @m_partID, @m_objID, @m_qty, @m_pnum, @m_koef -- , @m_koef_part
		
		while @@FETCH_STATUS = 0
		begin
			
			if @m_pnum is null -- no positions
			begin
				set @mass = @mass + dbo.getPosCmnMass2(@m_objID, @m_partID) * @m_qty --* @m_koef_part
			end
			else
			begin
				
				select @m_posID = posID from position where partID = @m_partID and posNumber = @m_pnum

				set @mass = @mass + dbo.getPosCmnMass2(2, @m_posID) * @m_qty * @m_koef --* @m_koef_part

			end
			
			
		
			fetch next from c1 into @m_partID, @m_objID, @m_qty, @m_pnum, @m_koef -- , @m_koef_part
		end
		
		close c1
		deallocate c1
	
	end


	-- Return the result of the function
	RETURN @mass;
	
END

--select parts_bkp2.dbo.getPosCmnMass2(7, 1774)





GO
