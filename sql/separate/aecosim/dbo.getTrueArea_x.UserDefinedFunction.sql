SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 21.07.2017
-- Description:	Получение площади помещения. Сравнение площади полученой из свойств AECOsim и утилитой Леонида. 
--Для помещений из смартсолид правильная площадь в AECOsim для фриформ от Леонида
--select dbo.getTrueArea(15,1)
-- THIS FUNCTION IS REPLACED BY [getTrueArea2] Leonid Vibe, 12/12/2018
-- =============================================
CREATE FUNCTION [dbo].[getTrueArea_x] 
(
	@AreaSim float,
	@AreaLeonid float
)
RETURNS real
AS
BEGIN
	-- Declare the return variable here
	DECLARE @TrueArea float

	IF @AreaLeonid = 0
		SET @TrueArea = @AreaSim 
	ELSE
		SET @TrueArea = @AreaLeonid

	
	RETURN @TrueArea

END


GO
