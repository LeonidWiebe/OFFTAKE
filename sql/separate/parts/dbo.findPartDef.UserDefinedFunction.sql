SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findPartDef]
(
	-- Add the parameters for the function here
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
	declare @prntcatID bigint = 0
	declare @ctID bigint = 0
	declare @relID bigint = 0
	declare @objID bigint = 0
	declare @objectID bigint = 0
	declare @partID bigint = 0
	declare @partQty real = 0.
	declare @clName varchar(250) = ''
	declare @catName varchar(250) = ''
	declare @objectName varchar(250) = ''
	declare @sortNumber varchar(250) = ''
	declare @isdel bit = 0
	declare @catunif bit = 0
	declare @isrunmet bit = 0
	declare @mass real = 0.
	declare @cnt int = 0
	
	if @catlistID = 0 RETURN
	
	
	declare c1 cursor read_only for select p.objID, p.partID, p.relID from r_catlist_part p where p.catlistID = @catlistID order by p.partSortID

	open c1
			
	fetch next from c1 into @objID, @objectID, @relID
	
	while @@FETCH_STATUS = 0
	begin
	
		if @objID = 14 -- catlist
		begin
			--insert @retTable 
			--select * from dbo.findPartDef(@partdefID, @objectID)
			
			select @cnt = count(p.relID) from dbo.findPartDef(@partdefID, @objectID) p
			
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
			
			--declare c2 cursor read_only for select p.relID from dbo.findPartDef(@partdefID, @objectID) p
			--open c2
			--fetch next from c2 into @ctID
			--if @@FETCH_STATUS != 0
			--begin
			--	insert @retTable 
			--	select @relID
			--end
			--close c2
			--deallocate c2
			
			
		end
		else if @objID = 7 -- catalog
		begin
		
			declare c2 cursor read_only for select p.partID, p.partdefID from part p where p.catID = @objectID-- and p.deleted = 0
			open c2
			fetch next from c2 into @partID, @ctID
			while @@FETCH_STATUS = 0
			begin
			
				if @ctID = @partdefID
				begin
					insert @retTable 
					select @relID
				end
			
				fetch next from c2 into @partID, @ctID
			end
			close c2
			deallocate c2
			
		end
		else if @objID = 1 -- part
		begin
			select @ctID = p.partdefID from part p where p.partID = @objectID
			if @ctID = @partdefID
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

--select * from dbo.findPartDef(15, 4940)




GO
