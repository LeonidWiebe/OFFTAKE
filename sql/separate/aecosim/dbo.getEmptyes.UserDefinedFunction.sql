SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO






-- =============================================
-- Author:		Kulakov Anatoly
-- Create date: 24.10.2018
-- Description:	Получение KKS в дереве Navisworks
--select [dbo].[getEmptyes] ('dbo.i_Space.number','1','2','3')
-- =============================================
CREATE FUNCTION [dbo].[getEmptyes] 
(
	--@Table_NM nvarchar(50),
	@ElementNM   nvarchar(50),
	@reserve	nvarchar(1),
	@reserve1	nvarchar(1),
	@reserve2	nvarchar(1)
)
RETURNS nvarchar(150)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Percent nvarchar(150);
	--DECLARE @TableNM TABLE
	DECLARE @Percent1 nvarchar(150);


		SELECT @Percent = COUNT(*) FROM dbo.i_Space 
		where @ElementNM = '' OR + @ElementNM = NULL
		--EXEC('SELECT COUNT(*)' +
		--'FROM ' +  @ElementNM + 
		--'where '+ @ElementNM + '= '' OR '+ @ElementNM + '= NULL')

		

		
		--SELECT @Percent1 = COUNT(*) FROM dbo.i_Space
		--) AS Roomallcount,

		--CAST(ROUND((SELECT CAST(COUNT(*) AS numeric) @TableNM  FROM @TableNM  where @ElementNM = '' OR @ElementNM = NULL)
		--/
		--(SELECT COUNT(*) FROM @TableNM)
		--*100, 1)AS decimal(10,1))
		--AS '% EMPTY',

		--return @ElementNM
		RETURN (@Percent); 
	--return @Percent1

END






GO
