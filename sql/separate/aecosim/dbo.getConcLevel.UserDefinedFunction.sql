SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO








-- =============================================
-- Author:		Kulakov
-- Create date: 15/03/2019
-- Description:	Получение отметки в древе АAECOsim/Concrete
-- SELECT [dbo].[getConcLevel]('Hanhikivi/10UKA-Opening-test/PKS2_10UKA10_A_Door',''Hanhikivi/10UKA-Opening-test/PKS2_10UKA10_A_Door'', 'dsds' )
-- =============================================
CREATE FUNCTION [dbo].[getConcLevel]
(
	@fullname varchar(200),
	@fullname2 varchar(200),
	@CivilCode varchar(20)
)
RETURNS varchar(50)
AS
BEGIN

    declare @RSLT varchar(100)
    declare @ST varchar(2)

	set @ST = '_'

	IF (@CivilCode is NULL OR @CivilCode = '') and CHARINDEX(@ST, @fullname) > 0
	SET @RSLT = SUBSTRING(@fullname, CHARINDEX(@ST, @fullname)+1, 7)
	

	ELSE IF (@CivilCode is NULL OR @CivilCode = '') and CHARINDEX(@ST, @fullname2) > 0
	SET @RSLT = SUBSTRING(@fullname2, CHARINDEX(@ST, @fullname2)+1, 7)
	ELSE
		
		Set @RSLT = @CivilCode

	return (@RSLT)

	
END





















GO
