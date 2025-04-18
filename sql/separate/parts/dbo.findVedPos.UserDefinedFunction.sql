SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findVedPos]
(
	-- Add the parameters for the function here
	@posdefID bigint,
	@matID bigint,
	@levnum integer, -- -1, 0, 1
	@catdefID bigint,
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
	declare @lev int = 0
	declare @prntcatID bigint = 0
	declare @catunif bit = 0
	
	if @catlistID = 0 RETURN
	
	
	declare c1 cursor read_only for select p.objID, p.partID, p.relID from r_catlist_part p where p.catlistID = @catlistID order by p.partSortID

	open c1
			
	fetch next from c1 into @objID, @objectID, @relID
	
	while @@FETCH_STATUS = 0
	begin
	
		if @objID = 14 -- catlist
		begin
			
			select @cnt = count(*) from dbo.findVedPos(@posdefID, @matID, @levnum, @catdefID, @partdefID, @objectID) p
			
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
		end
		else if @objID = 7 -- catalog
		begin
		
			set @lev = dbo.getLevNum(7, @objectID)
			
			select @ctID = p.catdefID from i_catalog p where p.catID = @objectID
			
			if (@levnum = 100 or @lev = @levnum) and (@catdefID = 0 or @ctID = @catdefID)
			begin
				select @cnt = count(*) 
				from part pt 
				inner join position p on pt.partID = p.partID
				inner join sortament sm on p.srtmID = sm.srtmID
				inner join r_standard_posdef spd on sm.stdposdefID = spd.relID
				inner join posdef pd on spd.posdefID = pd.posdefID
				where pt.catID = @objectID and pd.posdefID = @posdefID and p.matID = @matID and pt.partdefID = @partdefID
				
				if @cnt > 0
				begin
					insert @retTable 
					select @relID
				end
			end
		
			
		end
		else if @objID = 1 -- part
		begin
		
			select @prntcatID = p.catID from part p where p.partID = @objectID
			select @catunif = p.catUnif from i_catalog p where p.catID = @prntcatID
			
			if @catunif != 0
			begin
				select @prntcatID = p.catID from catlist p where p.catlistID = @catlistID
			end
		
			set @lev = dbo.getLevNum(7, @prntcatID)
			
			select @ctID = p.catdefID from i_catalog p where p.catID = @prntcatID
			
			if (@levnum = 100 or @lev = @levnum) and (@catdefID = 0 or @ctID = @catdefID)
			begin
				select @cnt = count(*) 
				from part pt 
				inner join position p on pt.partID = p.partID
				inner join sortament sm on p.srtmID = sm.srtmID
				inner join r_standard_posdef spd on sm.stdposdefID = spd.relID
				inner join posdef pd on spd.posdefID = pd.posdefID
				where pt.partID = @objectID and pd.posdefID = @posdefID and p.matID = @matID and pt.partdefID = @partdefID
				
				if @cnt > 0
				begin
					insert @retTable 
					select @relID
				end
			end
			
		end
	
	
	
	
		fetch next from c1 into @objID, @objectID, @relID
	end
	
	close c1
	deallocate c1
	
	
	
	RETURN 
END

--select * from dbo.findVedPos(1,11,1,12,2,5898)








GO
