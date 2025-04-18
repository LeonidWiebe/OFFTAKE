SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[gospec1]
(
	-- Add the parameters for the function here
	@listRowID bigint,
	@listRowObjID bigint,
	@listRowQty real
)
RETURNS 
@retSpecTable TABLE 
(
	-- Add the column definitions for the TABLE variable here
	partID bigint, 
	partName varchar(100),
	partDescr varchar(200),
	isrunmet bit,
	qty real
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
	
	declare @isrunmet bit = 0
	declare @partID bigint = 0
	declare @partName varchar(100)
	declare @partDescr varchar(200)
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
		p.partID, p.partName, p.partDescr
		from 
		part p 
		where p.partID = @listRowID

		open c1
				
		fetch next from c1 into @partID, @partName, @partDescr
		
		while @@FETCH_STATUS = 0
		begin
			
			set @isrunmet = dbo.isPartRun(@partID)
			
			insert @retSpecTable
			select @partID, @partName, @partDescr, @isrunmet, @listRowQty
		
			fetch next from c1 into @partID, @partName, @partDescr
		end
		
		close c1
		deallocate c1

	end
	--else if @listRowObjID = 7 -- catalog
	--begin
	--	declare c1 cursor read_only for select p.partID from part p where p.catID = @listRowID and p.deleted = 0
	--	open c1
	--	fetch next from c1 into @partID
	--	while @@FETCH_STATUS = 0
	--	begin
	--		insert @retSpecTable 
	--		select * from dbo.gospec1(@partID, 1, @listRowQty)
	--		fetch next from c1 into @partID
	--	end
	--	close c1
	--	deallocate c1
	--end
	else if @listRowObjID = 14 -- catlist
	begin
	
		declare c1 cursor read_only for select p.partID, p.objID, p.partQty from r_catlist_part p where p.catlistID = @listRowID
	
		open c1
				
		fetch next from c1 into @partID, @objID, @partQty
		
		while @@FETCH_STATUS = 0
		begin
			insert @retSpecTable 
			select * from dbo.gospec1(@partID, @objID, @listRowQty * @partQty)
	
			fetch next from c1 into @partID, @objID, @partQty
		end
		
		close c1
		deallocate c1
	
	end
	
	
	RETURN 
END

--select partName,partDescr,sum(qty) from dbo.gospec1(1595, 14, 1) group by partID,partName,partDescr





GO
