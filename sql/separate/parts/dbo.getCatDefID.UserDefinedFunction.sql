SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getCatDefID]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint
)
RETURNS bigint
AS
BEGIN
	-- Declare the return variable here
	DECLARE @m_catID bigint = 0;
	DECLARE @m_partID bigint = 0;
	DECLARE @m_catdefID bigint = 0;
	DECLARE @m_isDocSet bit = 0;
	
	if @objID is null RETURN 0
	if @objectID is null RETURN 0
	
	if @objID = 0 RETURN 0
	if @objectID = 0 RETURN 0

	if @objID = 1 -- part
	begin
		select @m_catID = p.catID from part p where p.partID = @objectID
		
		RETURN dbo.getCatDefID(7, @m_catID)
	end
	else if @objID = 2 -- pos
	begin
		select @m_partID = p.partID from position p where p.posID = @objectID
		
		RETURN dbo.getCatDefID(1, @m_partID)
	end
	else if @objID = 19 -- catpos
	begin
		select @m_catdefID = p.catdef from r_catpos_property p where p.posID = @objectID
		
		if @m_catdefID = 0 or @m_catdefID is null
		begin
			select @m_partID = p.partID from catpos p where p.posID = @objectID
			RETURN dbo.getCatDefID(7, @m_partID)
		end
		
	end
	else if @objID = 7 -- cat
	begin
	
		select @m_catdefID = p.catdefID from i_catalog p where p.catID = @objectID
			
	end
	else if @objID = 14 -- catlist
	begin
		select @m_catID = p.catID from catlist p where p.catlistID = @objectID
		
		RETURN dbo.getCatDefID(7, @m_catID)
	end

	-- Return the result of the function
	RETURN @m_catdefID
	
END










GO
