SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[isPartRun]
(
	-- Add the parameters for the function here
	@partID bigint
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @posID bigint;
	DECLARE @srtmID bigint;
	DECLARE @stdpdID bigint;
	DECLARE @pdID bigint;
	DECLARE @len real;
	DECLARE @mcID bigint;
	DECLARE @mcprID bigint;
	
	DECLARE @mc_ps_id bigint; -- position
	DECLARE @mc_sp_id bigint; -- stdpd
	DECLARE @mc_pd_id bigint; -- posdef

	select top 1
	@posID = s.posID,
	@mc_ps_id = s.mcID,
	@srtmID = s.srtmID
	from position s where s.partID = @partID and s.posNumber > 0 order by s.posNumber asc
	
	
	if (@posID is null) RETURN 0;
	if (@posID = 0) RETURN 0;

	if (@srtmID is null) RETURN 0;
	if (@srtmID = 0) RETURN 0;
	
	
	
	select 
	@stdpdID = r.stdposdefID
	from sortament r where r.srtmID = @srtmID
	
	if (@stdpdID is null) RETURN 0;
	if (@stdpdID = 0) RETURN 0;


	
	select 
	@mc_sp_id = r.mcID,
	@pdID = r.posdefID
	from r_standard_posdef r where r.relID = @stdpdID
	
	if (@pdID is null) RETURN 0;
	if (@pdID = 0) RETURN 0;
	
	
	
	select 
	@mc_pd_id = p.masscalcID
	from posdef p where p.posdefID = @pdID
	
	
	
	if @mc_pd_id > 0 set @mcID = @mc_pd_id
	if @mc_sp_id > 0 set @mcID = @mc_sp_id
	if @mc_ps_id > 0 set @mcID = @mc_ps_id
	
	
	
	select 
	@mcprID = r.relID
	from r_masscalc_property r where r.mcID = @mcID and r.propID = 1 -- lenght
	
	if (@mcprID is null) RETURN 0;
	if (@mcprID = 0) RETURN 0;


	select
	@len = r.length 
	from r_position_property r where r.posID = @posID

	if (@len is null)
	begin
		select
		@len = r.length 
		from r_sortament_property r where r.srtmID = @srtmID
	end
	
	if (@len is null) RETURN 1;
	if (@len = 0) RETURN 1;

	


	-- Return the result of the function
	RETURN 0;
	
END





GO
