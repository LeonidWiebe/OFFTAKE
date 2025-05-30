SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PosLength]
(
	-- Add the parameters for the function here
	@posID bigint,
	@projID bigint -- for rein lap
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ret real;
	DECLARE @defval real = 1000.;
	DECLARE @srtmID bigint;
	DECLARE @diam int;
	DECLARE @lap int;
	DECLARE @maxlen int;

	select 
	@ret = s.length
	from r_position_property s where s.posID = @posID

	if (@ret is null) set @ret = @defval;
	
	if @projID >= 0 --and @pdID = 1
	begin -- calc rein lap
	
		select 
		@srtmID = p.srtmid
		from position p where p.posID = @posID;
	
		select 
		@diam = convert(int, s.diameter)
		from r_sortament_property s where s.srtmID = @srtmID
		
		select
		@lap = s.lapValue,
		@maxlen = s.maxlen
		from rein_laps s where s.diameter = @diam and s.projectID = @projID and s.muft = 0
		
		if not @lap is null and @ret > @maxlen
		begin
			set @ret = (@ret + ceiling((@ret - @maxlen) / (@maxlen - @lap)) * @lap)
		end
	
	end

	-- Return the result of the function
	RETURN @ret;
	
END



GO
