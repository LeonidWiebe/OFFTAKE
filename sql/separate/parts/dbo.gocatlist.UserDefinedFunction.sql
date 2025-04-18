SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[gocatlist]
(
	-- Add the parameters for the function here
	@catlistID bigint
)
RETURNS 
@retCatListTable TABLE 
(
	-- Add the column definitions for the TABLE variable here
	partName varchar(250), 
	partQty real,
	partID bigint,
	partSortNumber varchar(250),
	catID bigint,
	partSortID bigint,
	catlistID bigint,
	relID bigint,
	catlistName varchar(250),
	deleted bit,
	catUnif bit,
	catName varchar(250),
	catTypeID bigint,
	partMainPosEP bit,
	objID bigint,
	partdefID bigint,
	projID bigint,
	blkID bigint
)
AS
BEGIN
	declare @prntcatID bigint = 0
	declare @objID bigint = 0
	declare @ctID bigint = 0
	declare @relID bigint = 0
	declare @partID bigint = 0
	declare @partSortID bigint = 0
	declare @partdefID bigint = 0
	declare @partQty real = 0.
	declare @clName varchar(250) = ''
	declare @catName varchar(250) = ''
	declare @objectName varchar(250) = ''
	declare @sortNumber varchar(250) = ''
	declare @isdel bit = 0
	declare @catunif bit = 0
	declare @isrunmet bit = 0
	declare @blkID bigint = 0
	declare @projID bigint = 0
	declare @partNameOver varchar(150)
	--declare @mass real = 0.
	
	if @catlistID = 0 RETURN
	
	
	declare c1 cursor read_only for select p.objID, p.partID, p.partQty, p.partSortID, p.relID, p.partNameOver from r_catlist_part p where p.catlistID = @catlistID

	select @clName = p.catlistName from catlist p where p.catlistID = @catlistID

	open c1
			
	fetch next from c1 into @objID, @partID, @partQty, @partSortID, @relID, @partNameOver
	
	while @@FETCH_STATUS = 0
	begin
	
		if @partID = 0
		begin
			set @prntcatID = 0
			--set @objID = 0
			set @ctID = 0
			--set @relID = 0
			--set @partID = 0
			--set @partSortID = 0
			set @partdefID = 0
			--set @partQty = 0.
			set @clName = ''
			set @catName = ''
			set @objectName = '#####'
			set @sortNumber = ''
			set @isdel = 0
			set @catunif = 0
			set @isrunmet = 0
			--set @mass = 0.
		end
		else if @objID = 1 -- part
		begin
			select 
			@objectName = p.partName, 
			@sortNumber = p.partSortNumber,
			@prntcatID = p.catID,
			@isdel = p.deleted,
			@partdefID = p.partdefID
			from part p where p.partID = @partID
			
			if not @partNameOver is null 
			begin
				if left(@partNameOver, len(@objectName)) = @objectName set @objectName = @partNameOver else set @objectName = @objectName + ' (' + @partNameOver + ')'
			end

			set @isrunmet = dbo.isPartRun(@partID)
			set @projID = dbo.getProjID(1, @partID)
			set @blkID = dbo.getBlockID(1, @partID)
		end
		else if @objID = 7 -- catalog
		begin
			select 
			@objectName = p.catName,
			@isdel = p.deleted,
			@prntcatID = p.catID
			from i_catalog p where p.catID = @partID
			
			set @sortNumber = @objectName
			set @projID = dbo.getProjID(7, @partID)
			set @blkID = dbo.getBlockID(7, @partID)
		end
		else if @objID = 14 -- catlist
		begin
			select 
			@objectName = p.catlistName,
			@isdel = p.deleted,
			@prntcatID = p.catID
			from catlist p where p.catlistID = @partID
			
			set @sortNumber = @objectName
			set @projID = dbo.getProjID(14, @partID)
			set @blkID = dbo.getBlockID(14, @partID)
		end
	
		if @prntcatID > 0
		begin
			select 
			@catunif = p.catUnif,
			@catName = p.catName,
			@ctID = p.catTypeID
			from i_catalog p where p.catID = @prntcatID
		end
	
		--set @mass = dbo.getPosCmnMass(@objID, @partID) * @partQty
	
	
		insert @retCatListTable 
		select @objectName, @partQty, @partID, @sortNumber, @prntcatID, @partSortID, @catlistID, @relID, @clName, @isdel, @catunif, @catName, @ctID, @isrunmet, @objID, @partdefID, @projID, @blkID
	
		fetch next from c1 into @objID, @partID, @partQty, @partSortID, @relID, @partNameOver
	end
	
	close c1
	deallocate c1
	
	
	
	RETURN 
END

--select * from dbo.gocatlist(21383)


GO
