SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findCatLev]
(
	-- Add the parameters for the function here
	@lev int,
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
	declare @prntcatID bigint = 0
	declare @curlev int = -1
	declare @cnt int = 0
	declare @objID bigint = 0
	declare @objectID bigint = 0
	declare @relID bigint = 0
	declare @catID bigint = 0
	declare @catunif bit = 0
	
	if @catlistID = 0 RETURN
	
	
	declare c1 cursor read_only for select p.objID, p.partID, p.relID from r_catlist_part p where p.catlistID = @catlistID order by p.partSortID

	open c1
			
	fetch next from c1 into @objID, @objectID, @relID
	
	while @@FETCH_STATUS = 0
	begin
	
		if @objID = 14 -- catlist
		begin
			
			select @cnt = count(p.relID) from dbo.findCatLev(@lev, @objectID) p
			
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
		end
		else if @objID = 7 -- catalog
		begin
		
			set @curlev = dbo.getLevNum(7, @objectID)
		
			if (@curlev is null and @lev = 0) or @curlev = @lev
			begin
				insert @retTable 
				select @relID
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
			
			set @curlev = dbo.getLevNum(7, @prntcatID)
	
			if (@curlev is null and @lev = 0) or @curlev = @lev
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

--select * from dbo.findCatLev(-1, 4940)






GO
