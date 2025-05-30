SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[seqq] 
(
	@clID bigint
)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @rID bigint
	declare @sid bigint
	
	set @sid = 1

	declare c1 cursor read_only for select relID from dbo.gocatlist(@clID) order by partSortNumber
	
	open c1
	
	
	fetch next from c1 into @rID
	
	while @@FETCH_STATUS = 0
	begin
	
		update r_catlist_part set partSortID = @sid where relID = @rID
		set @sid = @sid + 1
		fetch next from c1 into @rID
		
	
	end
	
	close c1
	deallocate c1
	

END
GO
