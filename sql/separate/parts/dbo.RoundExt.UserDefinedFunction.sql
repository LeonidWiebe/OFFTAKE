SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[RoundExt]
(
	-- Add the parameters for the function here
	@value real,
	@digits int = 1,
	@snap real = 10.,
	@shift int = 0
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ret real;
	
	set @ret = @value * POWER(@snap, @digits)
	
	set @ret = FLOOR(@ret + 0.555555555555555555555 - (0.111111111111111111111111 * @shift))
	
	set @ret = @ret / power(@snap, @digits)


	-- Return the result of the function
	RETURN @ret

END

GO
