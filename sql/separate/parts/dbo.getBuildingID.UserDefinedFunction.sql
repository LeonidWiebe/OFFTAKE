SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getBuildingID]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint
)
RETURNS bigint
AS
BEGIN
	-- Declare the return variable here
	DECLARE @m_objID bigint;
	DECLARE @m_objectID bigint;


	if @objID = 8 -- building
	begin
		return @objectID
	end

	if @objID = 7 -- catalog
	begin
		select 
		@m_objID = s.objID,
		@m_objectID = s.objectID
		from r_object_catalog s where s.catalogID = @objectID
		
		return [dbo].getBuildingID(@m_objID, @m_objectID)
	end

	if @objID = 1 -- part
	begin
		select 
		@m_objectID = s.catID
		from part s where s.partID = @objectID
		
		return [dbo].getBuildingID(7, @m_objectID)
	end


	if @objID = 14 -- catlist
	begin
		select 
		@m_objectID = s.catID
		from catlist s where s.catlistID = @objectID
		
		return [dbo].getBuildingID(7, @m_objectID)
	end
	
	-- Return the result of the function
	RETURN 0;
	
END


--select parts.dbo.getBuildingID(7, 7306)







GO
