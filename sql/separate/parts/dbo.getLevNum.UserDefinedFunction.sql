SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getLevNum]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @m_catlev int = 0;
	DECLARE @m_uplev int = 0;
	DECLARE @m_uplevover int = 0; -- @m_uplev override in docset
	DECLARE @m_catdefID bigint = 0;
	DECLARE @m_catID bigint = 0;
	DECLARE @m_partID bigint = 0;
	DECLARE @m_dsID bigint = 0;
	DECLARE @m_isDocSet bit = 0;
	DECLARE @mlev int = 0;
	
	if @objID is null RETURN 0
	if @objID = 0 RETURN 0
	if @objectID is null RETURN 0
	if @objectID = 0 RETURN 0
	

	if @objID = 1 -- part
	begin
		select @m_catID = p.catID from part p where p.partID = @objectID
		-- проверка на унифицированный
		
		RETURN dbo.getLevNum(7, @m_catID)
	end
	else if @objID = 2 -- pos
	begin
		select @m_partID = p.partID from position p where p.posID = @objectID
		
		RETURN dbo.getLevNum(1, @m_partID)
	end
	else if @objID = 7 -- cat
	begin
	
		select @m_catlev = p.dsLev, @m_catdefID = p.catdefID, @m_dsID = p.dsDrawingsID from i_catalog p where p.catID = @objectID
		
		if @m_catdefID > 0
		begin
			select @m_uplev = p.upLevel, @m_isDocSet = p.isDocSet from catdef p where p.catdefID = @m_catdefID
		
			if @m_isDocSet = 0 -- берем уровень из родительского каталога
			begin
				select @m_catID = p.objectID from r_object_catalog p where p.objID = 7 and p.catalogID = @objectID
				RETURN dbo.getLevNum(7, @m_catID)
			end
			else if @m_dsID > 0 -- если доксет задан - проверяем не задан ли уровень в нем
			begin 
				select @m_uplevover = p.dsLevel from docset p where p.dsID = @m_dsID
			end
		end
		else
			RETURN 0
		
		if @m_uplevover != 0 RETURN @m_uplevover
		
		if @m_uplev = -1 and @m_catlev = 0 set @m_catlev = 91
		
		if @m_catlev > 90 RETURN -1 else RETURN 1
	
	end
	else if @objID = 14 -- catlist
	begin
		select @m_catID = p.catID from catlist p where p.catlistID = @objectID
		
		RETURN dbo.getLevNum(7, @m_catID)
	end


	-- Return the result of the function
	RETURN @mlev
	
END

--select parts_bkp2.dbo.getLevNum(14, 3756)









GO
