SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[getTrueArea2] 
(
	@simID bigint,
	@isInUors bit,
	@roundVal int
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @areaGross real
	DECLARE @elemArea bigint
	DECLARE @elemAreaMan real
	DECLARE @uors bigint = 0

	select @elemAreaMan = elemareaMan, @uors = uors from dbo.elements where simID = @simID
	if not @elemAreaMan is null 
	begin
		if @isInUors = 1 set @elemAreaMan = @elemAreaMan * power(@uors,2)
		return round(@elemAreaMan, @roundVal)
	end

	select @elemArea = elemarea from dbo.elements where simID = @simID
	if @elemArea > 0
	begin
		if @isInUors = 1 return convert(real, @elemArea) else  return round(convert(real, @elemArea) * (1./power(@uors,2)), @roundVal)
	end

	select @areaGross = convert(real, actualGross) from dbo.i_Space where simID = @simID
	if @isInUors = 1 return @areaGross
	return round(@areaGross * (1./power(@uors,2)), @roundVal)

END


--select aecosim.[dbo].getZero2(aecosim.[dbo].getTrueArea2(339, 0, 2))
GO
