SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getPath2]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint,
	@short int
)
RETURNS varchar(500)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @objectName varchar(100);
	DECLARE @m_ID bigint;
	DECLARE @m_objID bigint;
	DECLARE @m_objectID bigint;
	DECLARE @blockNumber varchar(10);
	DECLARE @bldName varchar(200);
	DECLARE @delim varchar(10) = ' - ';
	
	
	if @objectID = 0 return ''
	

	if @objID = 10 -- project
	begin
		select 
		@objectName = s.projectName
		from i_project s where s.projectID = @objectID
		
		return @objectName
	end

	
	
	if @objID = 9 -- block
	begin
		select 
		@m_objectID = s.projectID,
		@blockNumber = convert(varchar, s.blockNumber)
		from i_block s where s.blockID = @objectID
		
		if @short > 0 set @blockNumber = 'Блок ' + @blockNumber

		return [dbo].getPath2(10, @m_objectID, @short) + @delim + @blockNumber
	end



	if @objID = 8 -- building
	begin
		select 
		@m_ID = s.buildingID,
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from i_building s where s.bldID = @objectID
		
		select 
		@objectName = s.buildingCode,
		@bldName = s.buildingName
		from c_building s where s.buildingID = @m_ID
		
		if not @bldName is null
		begin
		if @short > 0 and LEN(@bldName) > @short
			set @objectName = @objectName + ' (' + LEFT(@bldName, @short) + '...)'
		else
			if @short > 0 set @objectName = @objectName + ' (' + LEFT(@bldName, @short) + ')'
		end
		
		
		return [dbo].getPath2(@m_objID, @m_objectID, @short) + @delim + @objectName
	end


	if @objID = 27 -- pw building
	begin

		select 
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from i_building_pw s where s.buildingID = @objectID

		select 
		@objectName = s.bldname,
		@bldName = s.[PROJECT_DocumentMainTitleRus]
		from [view_object_catalog_pw] s where s.objectID = @objectID and s.objID = 27
		
		if not @bldName is null
		begin
		if @short > 0 and LEN(@bldName) > @short
			set @objectName = @objectName + ' (' + LEFT(@bldName, @short) + '...)'
		else
			if @short > 0 set @objectName = @objectName + ' (' + LEFT(@bldName, @short) + ')'
		end
		
		return [dbo].getPath2(@m_objID, @m_objectID, @short) + @delim + @objectName
	end


	if @objID = 7 -- catalog
	begin
		select 
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from r_object_catalog s where s.catalogID = @objectID
		
		select 
		@objectName = s.catName
		from i_catalog s where s.catID = @objectID
		
		return [dbo].getPath2(@m_objID, @m_objectID, @short) + @delim + @objectName
	end



	if @objID = 1 -- part
	begin
		select 
		@m_objectID = s.catID,
		@objectName = s.partName
		from part s where s.partID = @objectID
		
		return [dbo].getPath2(7, @m_objectID, @short) + @delim + @objectName
	end




	if @objID = 14 -- catlist
	begin
		select 
		@objectName = s.catlistName,
		@m_objectID = s.catID
		from catlist s where s.catlistID = @objectID
		
		return [dbo].getPath2(7, @m_objectID, @short) + @delim + @objectName
	end
	
	
	


	-- Return the result of the function
	RETURN '';
	
END


--select parts.dbo.getpath2(14, 10862, 0)





GO
