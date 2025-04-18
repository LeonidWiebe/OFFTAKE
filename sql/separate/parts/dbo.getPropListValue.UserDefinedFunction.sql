SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE FUNCTION [dbo].[getPropListValue]
(
	@roomID bigint,
	@propID bigint
)
RETURNS varchar(200)
AS
BEGIN

	DECLARE @val varchar(300) = '';
	DECLARE @ret varchar(300) = '';
	DECLARE @plID bigint = 0;

	declare c1 cursor read_only for select p.valueID from r_room_propertylist p where p.roomID = @roomID and p.propID = @propID

	open c1
			
	fetch next from c1 into @plID
	
	while @@FETCH_STATUS = 0
	begin
	
		select @val = p.plValue from propertylist p where p.plID = @plID
		
		if LEN(@ret) > 0 set @ret = @ret + ', '
		
		set @ret = @ret + @val

		fetch next from c1 into @plID
	end
	
	close c1
	deallocate c1


	if LEN(@ret) > 0 RETURN @ret

	return null

	
END

--select parts.dbo.[getPropListValue](10156, 48)








GO
