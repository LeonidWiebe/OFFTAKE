SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[getTrueSpaceHeight] 
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
	DECLARE @pMaxZ bigint = 0
	DECLARE @pMinZ bigint = 0
	DECLARE @hgt_mm bigint = 0
	DECLARE @dhgt_m real = 0.0
	

	select @prm = heightMan from dbo.i_Space where simID = @simID -- in m^3
	select @uors = uors, @pMinZ = pMinZ, @pMaxZ = pMaxZ from dbo.elements where simID = @simID
	
	--round((dbo.elements.pMaxZ - dbo.elements.pMinZ)* 1e-3, 1)  AS [Model Ceiling Height],
	set @hgt_mm = @pMaxZ - @pMinZ -- mm
	set @dhgt_m = @hgt_mm * 1e-3  -- m
	
	if not @prm is null 
	begin
		if @isInUors = 1 set @prm = @prm * 1000 * @uors -- (m -> mm)*uors
		return round(@prm, @roundVal)
	end
	
	if @hgt_mm != 0
	begin
		if @isInUors = 1 set @dhgt_m = @dhgt_m * @uors
		return round(@dhgt_m, @roundVal)
	end

	select @prm = height from dbo.i_Space where simID = @simID -- in uors
	if @prm > 0.001
	begin
		if @isInUors = 0 set @prm = @prm * (1./@uors)
		return round(@prm, @roundVal)
	end

	return round(@prm, @roundVal)

END




GO
