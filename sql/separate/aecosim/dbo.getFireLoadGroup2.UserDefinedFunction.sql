SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




-- =============================================
-- Author:		Leonid
-- Create date: 14.07.2020
-- Description:	пожарная нагрузка в соотвествии с процедурой
-- Select dbo.[getFireLoadGroup]('- less than 600 MJ/m^2')
-- =============================================
CREATE FUNCTION [dbo].[getFireLoadGroup2]
(
	@val nvarchar (50)
)
RETURNS nvarchar(50)  
AS
BEGIN

		--set @ret = '- less than 600 MJ/m^2'
		--set @ret = '- over than 1200 MJ/m^2'
		--set @ret = '- from 600 to 1200 MJ/m^2'


	
	DECLARE @ret nvarchar(50) = @val

	if CHARINDEX('less', @val) > 0 -- possible values <600, < 600
		set @ret = '<600'
	else if CHARINDEX('over', @val) > 0  -- possible values >1200, > 1200
		set @ret = '>1200'
	else if CHARINDEX('from', @val) > 0
		set @ret = '600-1200'
	

	RETURN @ret
END






GO
