SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO










-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getParKey]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint,
	@lev int 
)
RETURNS varchar(200)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @objectName varchar(200) = '';
	DECLARE @m_ID bigint;
	DECLARE @m_objID bigint;
	DECLARE @m_objectID bigint;
	DECLARE @objName varchar(200);

	if @objID = 10 -- project
		RETURN @objectName

	
	set @lev = @lev - 1
	
	
	if @objID = 9 -- block
	begin
		select 
		@m_objectID = s.projectID
		from i_block s where s.blockID = @objectID
		
		set @objectName = 'project' + convert(varchar, @m_objectID)
	end



	if @objID = 8 -- building
	begin
		select 
		@objName = p.objName,
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from i_building s 
		inner join [object] p on s.objID = p.objID
		where s.bldID = @objectID
		
		if @lev > 0
			set @objectName = dbo.getParKey(@m_objID, @m_objectID, @lev)
		else
			set @objectName = @objName + convert(varchar, @m_objectID)
	end




	if @objID = 7 -- catalog
	begin
		select 
		@objName = p.objName,
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from r_object_catalog s 
		inner join [object] p on s.objID = p.objID
		where s.catalogID = @objectID
		
		
		if @lev > 0
			set @objectName = dbo.getParKey(@m_objID, @m_objectID, @lev)
		else
			set @objectName = @objName + convert(varchar, @m_objectID)
	end




	if @objID = 14 -- catlist
	begin
		select 
		@m_objectID = s.catID
		from catlist s where s.catlistID = @objectID
		
		if @lev > 0
			set @objectName = dbo.getParKey(7, @m_objectID, @lev)
		else
			set @objectName = 'catalog' + convert(varchar, @m_objectID)
	end


	-- Return the result of the function
	RETURN @objectName;
	
END


--select parts_bkp2.dbo.getPrntKey(14,3008,2)









GO
