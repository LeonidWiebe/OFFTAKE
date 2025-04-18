SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[getSumSpaceArea] 
(
	-- Add the parameters for the function here
	@simid bigint,
	@roundVal int,
	@kks varchar(50),
	@fc1 varchar(50),
	@fc2 varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @totalarea varchar(50)
	DECLARE @elemArea bigint
	DECLARE @NumFireComp varchar(50)
	DECLARE @NumFireComp2 varchar(50)
	DECLARE @uors bigint = 0

	--SELECT [dbo].[getSumSpaceArea](14482,2,'60UKA22R111','60UKA22S111','60UKA013') as 'sedd'
	--SELECT [dbo].[getSumSpaceArea](14482,2,'60UKA22R111','Отсутствует/missing','60UKA013') as 'sedd'

		select @NumFireComp = NumFireComp from dbo.i_Space where NumFireComp = @fc1
		if not @NumFireComp is null
			begin		
				set @totalarea = @kks
				return @totalarea
			end
		else
			begin
				set @totalarea = @fc2
				set @totalarea = @totalarea + STR(dbo.getTrueArea2(@simID, 0, 2), 10, 1)
				return @totalarea
			end
		set @totalarea = @NumFireComp
		return @totalarea
END

GO
