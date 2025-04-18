SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		Pavel Dikalov
-- Create date: 20/07/2018
-- Description:	выделение отметки из названия
-- SELECT [dbo].[getLevel]('Hanhikivi/10UKA-Opening-test/FH1_10UKA10_A_Door')
-- =============================================
CREATE FUNCTION [dbo].[getLevel]
(
	@fullname varchar(200)
)
RETURNS varchar(10)
AS
BEGIN

    declare @RSLT varchar(10)
    declare @ST varchar(2)
	set @ST = '_'
	IF CHARINDEX(@ST, @fullname) > 0	      
	 Set @RSLT = SUBSTRING(@fullname, CHARINDEX(@ST, @fullname)+6, 2)
	  
	-- FH1_10UKA04_C_R  4.800	 
	
	IF ISNUMERIC(@RSLT) < 1
	   Set @RSLT = '&&'
	
	return (@RSLT)

	
END


















GO
