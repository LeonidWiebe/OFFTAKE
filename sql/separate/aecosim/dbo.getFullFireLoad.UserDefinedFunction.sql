SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- select dbo.getFullFireLoad(1592989, 'ceil', 2)

CREATE FUNCTION [dbo].[getFullFireLoad] 
(
	@simID bigint,
	@intype varchar(10),
	@roundVal int
)
RETURNS real
AS
BEGIN

	DECLARE @ffl float = 0.
	
	DECLARE @p varchar(50) = ''
	
	DECLARE @pp varchar(10) = ''
	DECLARE @ppp varchar(10) = ''
	
	DECLARE @x int = 0
	DECLARE @y int = 0
	
	DECLARE @ff real = 0.
	DECLARE @cc real = 0.
	
	DECLARE @fff real = 0.
	DECLARE @ccc real = 0.
	
	DECLARE @hgt real = 0.
	DECLARE @vol real = 0.
	DECLARE @area real = 0.
	DECLARE @iarea bigint = 0
	

	if @intype = 'floor'
	begin
		select @p = TopCoatLayer from dbo.i_Space where simID = @simID
		set @area = dbo.getTrueArea2(@simID, 0, 10)
	end
	else if @intype = 'wall'
	begin
		select @p = WallInteriorFinish from dbo.i_Space where simID = @simID
		set @area = dbo.getTrueVertArea(@simID, 0, 10)
	end
	else if @intype = 'ceil'
	begin
		select @p = CeilInteriorFinish from dbo.i_Space where simID = @simID
		set @area = dbo.getTrueArea2(@simID, 0, 10)
	end
	else
	begin
		return 0.
	end

	set @x = CHARINDEX(',', @p)
	set @y = CHARINDEX(' ', @p)

	if @y = 0 set @y = len(@p)+1

	if @x > 0 -- составной
	begin
		set @pp = SUBSTRING(@p, 1, @x-1)
		set @ppp = SUBSTRING(@p, @x+1, @y-1)
		
		set @iarea = CAST(@area as bigint)
		
		if @iarea > 0
		begin
			set @vol = dbo.getTrueVolume(@simID, 0, 10)
			set @hgt = @vol / @area
		end
		else return 0.
		
	end
	else
	begin
		set @pp = SUBSTRING(@p, 1, @y-1)
	end

	
	
	if LEN(@pp) > 0
	begin
		select @ff = lifFlowRate, @cc = lifCalorific from dbo.list_InteriorFinish where lifCode = @pp
		set @ffl = @ff * @area * @cc
	end


	if LEN(@ppp) > 0
	begin
		select @fff = lifFlowRate, @ccc = lifCalorific from dbo.list_InteriorFinish where lifCode = @ppp
		-- расчет составного значения
		-- ....
	end
	
	

	
	RETURN @ffl

END


GO
