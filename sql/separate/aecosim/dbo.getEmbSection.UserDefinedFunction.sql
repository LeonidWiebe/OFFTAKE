SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 16.07.2019
-- Description:	Получение Основного размера закладной
--select dbo.getEmbSection('446',NULL,'5',NULL,NULL,NULL,NULL,'139.7')

-- =============================================
CREATE FUNCTION [dbo].[getEmbSection] 
(
	--@posSection varchar(100),
	@posLen Float,
	@posThick1 int,
	@posThick2 int,
	@posThick3 int,
	@posThick4 int,
	@posWdt1 int,
	@posWdt2 int,
	@posDiam Float
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	declare @posSection varchar(100) = 100;
	declare @posThick int;
	declare @posWdt int;

	
		set @posSection = ''
		
		if not @posThick4 is null set @posThick = @posThick4
		if not @posThick3 is null set @posThick = @posThick3
		if not @posThick2 is null set @posThick = @posThick2
		if not @posThick1 is null set @posThick = @posThick1
		
		if not @posWdt2 is null set @posWdt = @posWdt2
		if not @posWdt1 is null set @posWdt = @posWdt1
		
		if not @posThick is null set @posSection = convert(varchar, @posThick)
			
		if not @posWdt is null
		begin
			if LEN(@posSection) > 0
				set @posSection = @posSection + 'x' + convert(varchar, @posWdt) -- ×
			else
				set @posSection = convert(varchar, @posWdt)
		end
			
		if not @posLen is null
		begin
			if LEN(@posSection) > 0
				set @posSection = @posSection + 'x' + convert(varchar, @posLen)
			else
				set @posSection = convert(varchar, @posLen)
		end
		
		if not @posDiam is null
		begin
			if not @posThick is null
				set @posSection = convert(varchar, @posDiam) + 'x' + convert(varchar, @posThick)
			else
				set @posSection = convert(varchar, @posDiam)
		end	

	RETURN @posSection

END


GO
