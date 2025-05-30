SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Leonid
-- Create date: 26.03.2020
-- Description:	пожарная нагрузка в соотвествии с процедурой
-- Select dbo.[getFireLoadGroup]('- less than 600 MJ/m^2')
-- =============================================
CREATE FUNCTION [dbo].[getFireLoadGroup]
(
	@val nvarchar (50)
)
RETURNS nvarchar(50)  
AS
BEGIN
	
	DECLARE @ret nvarchar(50) = @val

	if LEFT(@val,6) = '- less' return @ret
	if LEFT(@val,6) = '- over' return @ret
	if LEFT(@val,6) = '- from' return @ret

	if LEFT(@val,1) = '<' and CHARINDEX('600', @val) > 0 -- possible values <600, < 600
		set @ret = '- less than 600 MJ/m^2'
	else if LEFT(@val,1) = '>' and CHARINDEX('1200', @val) > 0  -- possible values >1200, > 1200
		set @ret = '- over than 1200 MJ/m^2'
	else if CHARINDEX('600', @val) > 0 and CHARINDEX('1200', @val) > 0
		set @ret = '- from 600 to 1200 MJ/m^2'
	else
		set @ret = 'not defined'
	

	RETURN @ret
END





GO
