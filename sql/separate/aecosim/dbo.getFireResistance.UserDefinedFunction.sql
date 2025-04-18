SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Vibe
-- Create date: 05.02.2021
-- Description:	пожарная отсек
-- =============================================
CREATE FUNCTION [dbo].[getFireResistance]
(
	@bld_fire_class nvarchar (max),
	@room_fire_hazard_class nvarchar (max),
	@room_fire_load nvarchar (max),
	@room_av_afes nvarchar (max), -- '+ - + - + + +'
	@fc_lev_min bigint, -- in mm
	@fc_lev_max bigint, -- in mm
	@bld_height bigint -- in mm
)
RETURNS nvarchar(max)  
AS
BEGIN

	
	DECLARE @ret nvarchar(max) = '60'

	if @bld_fire_class = 'P0' or @bld_fire_class = 'P1'
	begin
		if CHARINDEX('>', @room_fire_load) > 0 -- fire load > 1200
		begin
			if @fc_lev_min < 4900 -- есть помещение ниже 4,900
			begin
				if CHARINDEX('-', @room_av_afes) > 0 -- если есть тушение
					set @ret = '120'
				else
					set @ret = '90'
			end
			else -- надземная часть
			begin
				if @bld_height > 56000
				begin
					if CHARINDEX('-', @room_av_afes) > 0 -- если есть тушение
						set @ret = ''
					else
						set @ret = '90'
				end
				else
				begin
					if CHARINDEX('-', @room_av_afes) > 0 -- если есть тушение
						set @ret = '120'
					else
						set @ret = '60'
				end
			end
		end
		else if CHARINDEX('=', @room_fire_load) > 0 -- fire load > 600
		begin
			if @bld_height > 56000
			begin
				if CHARINDEX('-', @room_av_afes) > 0 -- если есть тушение
					set @ret = ''
				else
					set @ret = '60'
			end
			else
			begin
				if CHARINDEX('-', @room_av_afes) > 0 -- если есть тушение
					set @ret = '90'
				else
					set @ret = '60'
			end
		end
		else -- @room_fire_load < 600
		begin
			set @ret = '60'
		end
	end
	else -- if @bld_fire_class = 'P2'
	begin
		set @ret = '60'
	end

	/*
	if CHARINDEX('less', @val) > 0 -- possible values <600, < 600
		set @ret = '<600'
	else if CHARINDEX('over', @val) > 0  -- possible values >1200, > 1200
		set @ret = '>1200'
	else if CHARINDEX('from', @val) > 0
		set @ret = '600-1200'
	*/

	--if len(@ret) > 0 set @ret = 'EI' + @ret


	RETURN @ret
END


/*
select [dbo].[getFireResistance]('P0', '', '=<', '--', 27000,38000,89000)
	@bld_fire_class nvarchar (max),
	@room_fire_hazard_class nvarchar (max),
	@room_fire_load nvarchar (max),
	@room_av_afes nvarchar (max), -- '+ - + - + + +'
	@fc_lev_min bigint, -- in mm
	@fc_lev_max bigint, -- in mm
	@bld_height bigint -- in mm
*/
GO
