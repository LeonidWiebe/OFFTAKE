SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[test]
(
	--@folderID int
)
RETURNS int
AS
BEGIN
	declare @a int  =null
	declare @b int

	if not (@a is null or @a = 0) 
		set @b = 0
	else 
		set @b = 1

	return @b

	
END


/*
select dbo.test()
*/

GO
