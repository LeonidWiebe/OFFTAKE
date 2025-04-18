SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findPosSrtm3]
(
	-- Add the parameters for the function here
	@srtmID bigint,
	@matID bigint,
	@partdefID bigint,
	@catlistID bigint
)
RETURNS 
@retTable TABLE 
(
	-- Add the column definitions for the TABLE variable here
	relID bigint
)
AS
BEGIN

	declare @ctID bigint = 0
	declare @relID bigint = 0
	declare @objID bigint = 0
	declare @objectID bigint = 0
	declare @partID bigint = 0
	declare @cnt int = 0
	
	if @catlistID = 0 RETURN
	
	
	declare c1 cursor read_only for select p.objID, p.partID, p.relID from r_catlist_part p where p.catlistID = @catlistID order by p.partSortID

	open c1
			
	fetch next from c1 into @objID, @objectID, @relID
	
	while @@FETCH_STATUS = 0
	begin
	
		if @objID = 14 -- catlist
		begin
			
			select @cnt = count(*) from dbo.findPosSrtm3(@srtmID, @matID, @partdefID, @objectID) p
			
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
		end
		else if @objID = 7 -- catalog
		begin
		
			if @matID = 0 or @matID is null
			begin
				select @cnt = count(*) 
				from part pt 
				inner join position p
				on pt.partID = p.partID
				where pt.catID = @objectID and p.srtmID = @srtmID and (p.matID = 0 or p.matID is null) and pt.partdefID = @partdefID
			end
			else
			begin
				select @cnt = count(*) 
				from part pt 
				inner join position p
				on pt.partID = p.partID
				where pt.catID = @objectID and p.srtmID = @srtmID and p.matID = @matID and pt.partdefID = @partdefID
			end
			
			
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
		end
		else if @objID = 1 -- part
		begin
		
			if @matID = 0 or @matID is null
			begin
				select @cnt = count(*) 
				from part pt 
				inner join position p
				on pt.partID = p.partID
				where pt.partID = @objectID and p.srtmID = @srtmID and (p.matID = 0 or p.matID is null) and pt.partdefID = @partdefID
			end
			else
			begin 
				select @cnt = count(*) 
				from part pt 
				inner join position p
				on pt.partID = p.partID
				where pt.partID = @objectID and p.srtmID = @srtmID and p.matID = @matID and pt.partdefID = @partdefID
			end
		
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
		end
	
	
	
	
		fetch next from c1 into @objID, @objectID, @relID
	end
	
	close c1
	deallocate c1
	
	
	
	RETURN 
END

--select * from findPosSrtm3(495,0,2,11062)








GO
