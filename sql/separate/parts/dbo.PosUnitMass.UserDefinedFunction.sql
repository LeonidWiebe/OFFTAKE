SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[PosUnitMass]
(
	-- Add the parameters for the function here
	@posID bigint,
	@projID bigint
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ret real;
	DECLARE @cum bit;
	DECLARE @partID bigint;
	DECLARE @srtmID bigint;
	DECLARE @stdpdID bigint;
	DECLARE @pdID bigint;
	DECLARE @mcID bigint;
	DECLARE @digits int;
	DECLARE @shift int = 0;

	DECLARE @mc_ps_id bigint; -- position
	DECLARE @mc_sp_id bigint; -- stdpd
	DECLARE @mc_pd_id bigint; -- posdef
	
	declare @mass real;
	declare @k real;
	declare @prm1 real;
	declare @prm2 real;
	declare @prm3 real;
	declare @prm4 real;

	select 
	@ret = p.posUnitMass, 
	@cum = p.posUMCalc, 
	@srtmID = p.srtmid,
	@mc_ps_id = p.mcID,
	@digits = p.numDigits,
	@partID = p.partID
	from position p where p.posID = @posID;
	
	select @shift = p.partRoundShift from part p where p.partID = partID 
	
	select @stdpdID = s.stdposdefID
	from sortament s where s.srtmID = @srtmID
	
	select 
	@mc_sp_id = r.mcID,
	@pdID = r.posdefID
	from r_standard_posdef r where r.relID = @stdpdID
	
	select @mc_pd_id = p.masscalcID
	from posdef p where p.posdefID = @pdID


	if @mc_pd_id > 0 set @mcID = @mc_pd_id
	if @mc_sp_id > 0 set @mcID = @mc_sp_id
	if @mc_ps_id > 0 set @mcID = @mc_ps_id


	if (@cum = 0) -- не считать
	begin
		if (@ret is null) set @ret = 0.;
		RETURN @ret;
	end
	
	if @mcID = 1
		select @mass = s.massunit from r_sortament_property s where s.srtmID = @srtmID 
	else if @mcID = 2
		select @mass = s.masslength from r_sortament_property s where s.srtmID = @srtmID 
	else if @mcID = 3 or @mcID = 9
		select @mass = s.massarea from r_sortament_property s where s.srtmID = @srtmID 
	else
		select @mass = s.massvolume from r_sortament_property s where s.srtmID = @srtmID 



	if @mcID = 1
		set @k = 1.
	else if @mcID = 2
		set @k = dbo.PosLength(@posID, @projID) * 1e-3
	else if @mcID = 3
		begin
		select @prm1 = s.area from r_position_property s where s.posID = @posID 
		set @k = @prm1
		end
	else if @mcID = 4
		begin
		select @prm1 = s.volume from r_position_property s where s.posID = @posID 
		set @k = @prm1
		end
	else if @mcID = 5
		set @k = 1. -- tmp
	else if @mcID = 6
		begin
		select @prm1 = s.area from r_position_property s where s.posID = @posID 
		select @prm2 = s.thickness * 1e-3 from r_position_property s where s.posID = @posID 
		set @k = @prm1 * @prm2
		end
	else if @mcID = 7
		begin
		select @prm1 = s.length * 1e-3 from r_position_property s where s.posID = @posID 
		select @prm2 = s.width * 1e-3 from r_position_property s where s.posID = @posID 
		select @prm3 = s.thickness * 1e-3 from r_position_property s where s.posID = @posID 
		set @k = @prm1 * @prm2 * @prm3
		end
	else if @mcID = 8
		begin
		select @prm1 = s.segment * 0.00277777777777777 from r_position_property s where s.posID = @posID 
		select @prm2 = s.radiusout * 1e-3 from r_position_property s where s.posID = @posID 
		select @prm3 = s.radiusinn * 1e-3 from r_position_property s where s.posID = @posID 
		select @prm4 = s.thickness * 1e-3 from r_position_property s where s.posID = @posID 
		set @k = @prm4 * PI() * (power(@prm2,2) - power(@prm3,2)) * @prm1
		end
	else if @mcID = 9
		begin
		select @prm1 = s.length * 1e-3 from r_position_property s where s.posID = @posID 
		select @prm2 = s.width * 1e-3 from r_position_property s where s.posID = @posID 
		set @k = @prm1 * @prm2
		end
	else if @mcID = 10
		set @k = 0.
	else if @mcID = 11
		begin
		select @prm1 = s.segment * 0.00277777777777777 from r_position_property s where s.posID = @posID 
		select @prm2 = s.diamout * 1e-3 / 2. from r_position_property s where s.posID = @posID 
		select @prm3 = s.diaminn * 1e-3 / 2. from r_position_property s where s.posID = @posID 
		select @prm4 = s.thickness * 1e-3 from r_position_property s where s.posID = @posID 
		set @k = @prm4 * PI() * (power(@prm2,2) - power(@prm3,2)) * @prm1
		end
	else
		set @k = 0.
	
	
	set @ret = dbo.roundext( @mass * @k , @digits, 10., @shift)

	-- Return the result of the function
	RETURN @ret;

END

GO
