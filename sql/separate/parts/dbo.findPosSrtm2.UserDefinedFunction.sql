SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findPosSrtm2]
(
	-- Add the parameters for the function here
	@srtmID bigint,
	@catlistID bigint,
	@isCatPos bit
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
			
			select @cnt = count(*) from dbo.[findPosSrtm2](@srtmID, @objectID, @isCatPos) p
			
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
		end
		else if @objID = 7 -- catalog
		begin
		
			if @isCatPos != 0
			begin
				select @cnt = count(*) 
				from i_catalog pt 
				inner join catpos p
				on pt.catID = p.partID
				where pt.catID = @objectID and p.srtmID = @srtmID
				
				if @cnt > 0
				begin
					insert @retTable 
					select @relID
				end
			end
			
			if @isCatPos <= 0
			begin
				select @cnt = count(*) 
				from part pt 
				inner join position p
				on pt.partID = p.partID
				where pt.catID = @objectID and p.srtmID = @srtmID
				
				if @cnt > 0
				begin
					insert @retTable 
					select @relID
				end
			end
			
			
		end
		else if @objID = 1 -- part
		begin
		
			select @cnt = count(*) 
			from position p 
			where p.partID = @objectID and p.srtmID = @srtmID
			
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

--select * from dbo.findPosSrtm(15, 4940)








GO
