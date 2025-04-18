SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[isCatBlocked]
(
	-- Add the parameters for the function here
	@catID bigint,
	@usrID bigint
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @catstatus int;
	DECLARE @catopen bit;
	DECLARE @objID bigint;
	DECLARE @objectID bigint;
	DECLARE @cnt int;

	if @catID = 0 return 0

	select @catopen = i.catOpen, @catstatus = i.catStatus from i_catalog i where i.catID = @catID
	
	if @catstatus > 0 return 1
	
	select @objID = i.objID, @objectID = i.objectID from r_object_catalog i where i.catalogID = @catID
	
	if @objID = 7 -- catalog
		return dbo.isCatBlocked(@objectID, @usrID)
	
	if @catopen != 0 return 0 -- cat open, no block
	
	-- cat not open
	
	if @usrID = 0 return 0 -- user unknown, no block
	
	select @cnt = COUNT(*) from r_usr_catalog i where i.catID = @catID and i.usrID = @usrID
	
	if @cnt > 0 return 0 -- user exist, no block
	
	
	return 1 -- block
	
	
	
END






GO
