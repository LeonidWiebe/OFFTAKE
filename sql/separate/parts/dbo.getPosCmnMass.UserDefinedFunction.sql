SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getPosCmnMass]
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
	DECLARE @m_objID bigint = 0;
	DECLARE @m_qty real = 0.;

	if @objID = 1 -- part
	begin
		select @mass = sum(p.posCommonMass) from position p where p.partID = @objectID
		if @mass is null set @mass = 0.
	end
	else if @objID = 7 -- cat
	begin
	
		declare c1 cursor read_only for select p.partID from part p where p.catID = @objectID and p.deleted = 0

		open c1
				
		fetch next from c1 into @m_partID
		
		while @@FETCH_STATUS = 0
		begin
			set @mass = @mass + dbo.getPosCmnMass(1, @m_partID)
		
			fetch next from c1 into @m_partID
		end
		
		close c1
		deallocate c1
	
	end
	else if @objID = 14 -- catlist
	begin
	
		declare c1 cursor read_only for select p.partID, p.objID, p.partQty  from r_catlist_part p where p.catlistID = @objectID

		open c1
				
		fetch next from c1 into @m_partID, @m_objID, @m_qty
		
		while @@FETCH_STATUS = 0
		begin
			set @mass = @mass + dbo.getPosCmnMass(@m_objID, @m_partID) * @m_qty
		
			fetch next from c1 into @m_partID, @m_objID, @m_qty
		end
		
		close c1
		deallocate c1
	
	end


	-- Return the result of the function
	RETURN @mass;
	
END

--select parts_bkp2.dbo.getPosCmnMass(7, 1774)





GO
