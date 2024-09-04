SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO











-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getCatDef2]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint,
	@catdefID bigint
)
RETURNS varchar(250)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @m_catID bigint = 0;
	DECLARE @m_partID bigint = 0;
	DECLARE @m_catdefID bigint = 0;
	DECLARE @m_catdefName varchar(250) = 'Не определено';
	

	if @catdefID > 0
		set @m_catdefID = @catdefID
	else
		set @m_catdefID = dbo.getCatDefID(@objID, @objectID)

	if @m_catdefID > 0
		select @m_catdefName = p.catdefName from catdef p where p.catdefID = @m_catdefID

	-- Return the result of the function
	RETURN @m_catdefName
	
END

--select parts_bkp2.dbo.getPosCmnMass(7, 1774)











GO
