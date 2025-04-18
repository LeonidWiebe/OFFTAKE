SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 29.03.2019
-- Description:	Получение Thiknes для Слоев бетонных элементов по Пакш-2
--select dbo.getLaerThiknes('Concrete Column',NULL, 14,'-')

-- =============================================
CREATE FUNCTION [dbo].[getLaerThiknes] 
(
    @ObjectName varchar (200),
	@SlabeThiknes nvarchar (50),
	@WallThiknes nvarchar(50),
	@Othe nvarchar(50)
)
RETURNS nvarchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Thiknes nvarchar (50)

 IF @WallThiknes is NULL AND @SlabeThiknes is NULL
	SET @Thiknes = @Othe 

ELSE 	IF @SlabeThiknes is NULL
		SET @Thiknes = @WallThiknes 

	ELSE  IF @WallThiknes is NULL
		SET @Thiknes = @SlabeThiknes
	

	IF @ObjectName = 'Concrete Column' SET @Thiknes = @Othe
	IF @ObjectName = 'Concrete Beam' SET @Thiknes = @Othe
	

	RETURN @Thiknes

END





GO
