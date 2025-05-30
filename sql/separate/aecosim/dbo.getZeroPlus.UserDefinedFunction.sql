SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 21.07.2017
-- Description:	Получение ноля после запитой для целых чисел (20,0) и + для отметок
--select dbo.getZeroPlus(-0.1)
-- =============================================
CREATE FUNCTION [dbo].[getZeroPlus] 
(
	@float float
)
RETURNS varchar(50)
BEGIN
	Declare @varchar as varchar(50)

	Set @varchar = LTRIM(STR(@float,50,3))
	if (@float > 0) set @varchar = '+' +  @varchar
	else if (@float = 0) set @varchar = '±' +  @varchar
	RETURN @varchar
END






GO
