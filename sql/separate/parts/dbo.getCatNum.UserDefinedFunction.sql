SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getCatNum]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint,
	@dstypeID bigint,
	@specID bigint = 1 -- строители
)
RETURNS varchar(500)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @objectName varchar(100);
	DECLARE @m_ID bigint;
	DECLARE @m_objID bigint;
	DECLARE @m_objectID bigint;
	DECLARE @m_specID bigint;
	
	DECLARE @catID bigint;
	
	DECLARE @prjID bigint;
	DECLARE @prjCode varchar(10) = '&&&&';
	
	DECLARE @ibldID bigint;
	DECLARE @cbldID bigint;
	DECLARE @bldCode varchar(10) = '&&&&';
	
	DECLARE @num1 varchar(10);
	DECLARE @num2 varchar(10);
	DECLARE @num3 varchar(10);
	
	DECLARE @blkNum as int = 0;
	
	DECLARE @cnt as int = 0;

	--DECLARE @dsID as int = 0; 
	--DECLARE @dspID as int = 0; -- part list
	--DECLARE @dsdID as int = 0; -- drawings
	DECLARE @dsLev as int = 0;
	DECLARE @dsNum as int = 0;
	DECLARE @sLev as varchar(10) = '&&';
	DECLARE @sNum as varchar(10) = '&&&&';
	DECLARE @dsMask as varchar(100) = '';
	DECLARE @dsLead as int = 0;


	if @objID = 1 -- part
	begin
		select 
		@catID = s.catID
		from part s where s.partID = @objectID
	end

	if @objID = 7 -- catalog
	begin
		set @catID = @objectID
	end
	
	select 
	@catID = s.catID,
	@dsLev = s.dsLev,
	@dsNum = s.dsNum,
	@m_specID = s.specID
	from i_catalog s where s.catID = @catID
	
	-- ==== user spec ====
	if @m_specID = 0 set @m_specID = @specID
	if @m_specID = 0 set @m_specID = 1
	
	select 
	@num1 = s.num1,
	@num2 = s.num2,
	@num3 = s.num3
	from specialty s where s.specID = @m_specID
	
	if @num1 is null set @num1 = 'PD23'
	if @num2 is null set @num2 = '12'
	if @num3 is null set @num3 = 'DG'
	-- =================
	
	
	if not @dsLev is null 
	begin
		if @dsLev >=0 set @sLev = convert(varchar, @dsLev)
	end
	
	if not @dsNum is null 
	begin
		if @dsNum >=0 set @sNum = convert(varchar, @dsNum)
	end


	select 
	@m_objID = s.objID,
	@m_objectID = s.objectID
	from r_object_catalog s where s.catalogID = @catID


	if @m_objID = 7 -- catalog
	begin
	
		set @cnt = 0
	
		while @m_objID = 7
		begin
			select 
			@m_objID = s.objID,
			@m_objectID = s.objectID
			from r_object_catalog s where s.catalogID = @m_objectID
			
			set @cnt = @cnt + 1
			
			if @cnt > 1000 break -- на всякий случай
		end
	end



	if @m_objID = 8 -- building
	begin
		set @ibldID = @m_objectID
	
		select 
		@cbldID = s.buildingID,
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from i_building s where s.bldID = @ibldID
		
		select 
		@bldCode = s.buildingCode
		from c_building s where s.buildingID = @cbldID
	end



	if @m_objID = 27 -- pw building
	begin
		set @ibldID = @m_objectID
	
		select 
		@cbldID = s.buildingID,
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from i_building_pw s where s.buildingID = @ibldID
		
		set @bldCode = '###'

		--select 
		--@bldCode = s.buildingCode
		--from c_building s where s.buildingID = @cbldID
	end



	if @m_objID = 9 -- block
	begin
		select 
		@prjID = s.projectID,
		@blkNum = s.blockNumber
		from i_block s where s.blockID = @m_objectID
	end


	if @m_objID = 10 -- project
	begin
		set @prjID = @m_objectID
	end

	
	select 
	@prjCode = s.projectCode
	from i_project s where s.projectID = @prjID
	


	select 
	@dsLead = s.bldLeadSign,
	@dsMask = s.nmbMask
	from docsetnumber s where s.projectID = @prjID and s.dstID = @dstypeID

	
	if LEN(@dsMask) = 0 RETURN ''
	
	if LEN(@bldCode) = 3 set @bldCode = CONVERT(varchar, @dsLead) + @bldCode
	if LEN(@bldCode) > 4 set @bldCode = RIGHT(@bldCode, 4)
	
	
	set @dsMask = REPLACE(@dsMask, '[PRJ]', @prjCode);
	set @dsMask = REPLACE(@dsMask, '[PROJ]', @prjCode);
	set @dsMask = REPLACE(@dsMask, '[B]', CONVERT(varchar, @blkNum));
	set @dsMask = REPLACE(@dsMask, '[NBLD]', @bldCode);
	set @dsMask = REPLACE(@dsMask, '[LV]', REPLICATE('0', 2 - len(@sLev)) + @sLev);
	set @dsMask = REPLACE(@dsMask, '[NUMB]', REPLICATE('0', 4 - len(@sNum)) + @sNum);
	set @dsMask = REPLACE(@dsMask, '[NUM2]', REPLICATE('0', 2 - len(@sNum)) + @sNum);
	set @dsMask = REPLACE(@dsMask, '[NUM3]', REPLICATE('0', 3 - len(@sNum)) + @sNum);
	set @dsMask = REPLACE(@dsMask, '[NUM4]', REPLICATE('0', 4 - len(@sNum)) + @sNum);
	set @dsMask = REPLACE(@dsMask, '[NUM5]', REPLICATE('0', 5 - len(@sNum)) + @sNum);
	set @dsMask = REPLACE(@dsMask, '[NUM6]', REPLICATE('0', 6 - len(@sNum)) + @sNum);

	set @dsMask = REPLACE(@dsMask, '[NNN1]', @num1);
	set @dsMask = REPLACE(@dsMask, '[N2]', @num2);
	set @dsMask = REPLACE(@dsMask, '[N3]', @num3);

	-- Return the result of the function
	RETURN @dsMask;
	
END


--select parts_bkp.dbo.getcatnum(7, 14269, 2, 1)

--dbcc freeproccache 
--dbcc dropcleanbuffers





GO
