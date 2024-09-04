SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 21.07.2017
-- Description:	Очитска строки от лишних символов
--select dbo.getTrim(15.1)
-- =============================================
CREATE FUNCTION [dbo].[getTrim] 
(
	@float float
)
RETURNS varchar(50)
BEGIN
	Declare @varchar as varchar(50)

	Set @varchar = LTRIM(RTRIM(STR(@float,50,1)))

	RETURN @varchar
END





GO
