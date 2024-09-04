SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getLevel2]
(
	-- Add the parameters for the function here
	@objID bigint = 0,
	@objectID bigint = 0,
	@levum int = 0
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @mlev int = 0;
	
	if @objID is null set @objID = 0
	if @objectID is null set @objectID = 0
	
	if @objID > 0 and @objectID > 0 
		set @mlev = dbo.getlevNum(@objID, @objectID)
	else
		set @mlev = @levum
	
		
	if @mlev = -1 
		RETURN 'Подземная часть' 
	else if @mlev = 1
		RETURN 'Надземная часть'
		
	RETURN 'Уровень не определен'
	-- Return the result of the function
	
END










GO
