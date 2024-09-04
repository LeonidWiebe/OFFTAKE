SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getLevel]
(
	-- Add the parameters for the function here
	@objID bigint,
	@objectID bigint
)
RETURNS varchar(100)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @mlev int = 0;
	
	set @mlev = dbo.getlevNum(@objID, @objectID)
		
	if @mlev = -1 
		RETURN 'Подземная часть' 
	else if @mlev = 1
		RETURN 'Надземная часть'
		
	RETURN 'Уровень не определен'
	-- Return the result of the function
	
END

--select parts_bkp2.dbo.getPosCmnMass(7, 1774)







GO
