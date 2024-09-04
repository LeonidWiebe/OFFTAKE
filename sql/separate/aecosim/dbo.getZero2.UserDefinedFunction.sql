SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO







-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 21.07.2017
-- Description:	Получение ноля после запитой для целых чисел (20,0)
--select dbo.getZero(-0.0)
-- =============================================
CREATE FUNCTION [dbo].[getZero2] 
(
	@float float
)
RETURNS varchar(50)
BEGIN
	Declare @varchar as varchar(50)

	Set @varchar = LTRIM(STR(@float,50,2))
	RETURN @varchar
END






GO
