SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[getTrueVertArea] 
(
	@simID bigint,
	@isInUors bit, -- 0 если в кубических метрах, 1 если в единицах UOR (1 метр = 1e5 uors, 1 кв.метр = 1e10 uors, 1 куб.метр = 1e15 uors)
	@roundVal int -- количество знаков после запятой при округлении, см функцию ROUND()
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @prm real = 0.0
	DECLARE @uors bigint = 0

	select @prm = elemvertareaMan, @uors = uors from dbo.elements where simID = @simID -- in m^3
	
	if not @prm is null 
	begin
		if @isInUors = 1 set @prm = @prm * POWER(@uors,2)
		return round(@prm, @roundVal)
	end

	select @prm = elemvertarea from dbo.elements where simID = @simID -- in uors
	if @prm > 0.001
	begin
		if @isInUors = 0 set @prm = @prm * (1./POWER(@uors,2))
		return round(@prm, @roundVal)
	end

	return round(@prm, @roundVal)

END




GO
