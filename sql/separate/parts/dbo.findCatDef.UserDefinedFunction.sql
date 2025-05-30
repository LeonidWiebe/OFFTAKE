SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[findCatDef]
(
	-- Add the parameters for the function here
	@catdefID bigint,
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
			
			select @cnt = count(p.relID) from dbo.findCatDef(@catdefID, @objectID) p
			
			if @cnt > 0
			begin
				insert @retTable 
				select @relID
			end
			
		end
		else if @objID = 7 -- catalog
		begin
		
			select @ctID = p.catdefID from i_catalog p where p.catID = @objectID and p.deleted = 0
		
			if @ctID = @catdefID
			begin
				insert @retTable 
				select @relID
			end
			
		end
		else if @objID = 1 -- part
		begin
			select @prntcatID = p.catID, @objectName = p.partName from part p where p.partID = @objectID
			select @catunif = p.catUnif, @ctID = p.catdefID from i_catalog p where p.catID = @prntcatID
			
			if @catunif != 0
			begin
				select @prntcatID = p.catID from catlist p where p.catlistID = @catlistID
				select @ctID = p.catdefID from i_catalog p where p.catID = @prntcatID
			end
	
			if @ctID = @catdefID
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

--select * from dbo.findCatDef(0, 4940)





GO
