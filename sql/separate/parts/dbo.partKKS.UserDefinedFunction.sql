SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[partKKS]
(
	-- Add the parameters for the function here
	@partID bigint
)
RETURNS varchar(500)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @prjID bigint;
	DECLARE @bn bigint;
	DECLARE @sys  varchar(10);
	DECLARE @num int;
	DECLARE @kks varchar(50)='';
	DECLARE @div varchar(10);
	DECLARE @pdID bigint;
	
	set @prjID = dbo.getProjID(1, @partID);
	set @bn = dbo.getBlockNum(1, @partID);


	select 
	@pdID = r.partdefID
	from part r where r.partID = @partID

	select 
	@div = r.kksDiv
	from partdef r where r.partdefID = @pdID


	
	
	declare c1 cursor read_only for select p.kksSys, p.kksNum from r_part_kks p where p.partID = @partID and p.projectID = @prjID

	open c1
			
	fetch next from c1 into @sys, @num
	
	while @@FETCH_STATUS = 0
	begin
	
		if LEN(@kks) > 0 set @kks = @kks + ','
		set @kks = @kks + CONVERT(varchar, @bn) + '0' + @sys + @div + REPLICATE('0', 3 - len(@num)) + CONVERT(varchar, @num);
	

		fetch next from c1 into @sys, @num
	end
	
	close c1
	deallocate c1

	

	-- Return the result of the function
	RETURN @kks;
	
END





GO
