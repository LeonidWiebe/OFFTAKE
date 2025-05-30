SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[proc_i_ProcessRecords]
	--@pdsID bigint = 0,
	--@catID bigint = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	declare @cnt bigint = 0
	
	declare @simID bigint = 0
	declare @dtID bigint = 0
	declare @table_name varchar(150) = ''
	declare @prop_name varchar(150) = ''
	declare @prop_value varchar(250) = ''
	
	declare @fparam nvarchar(250) = ''
	
	declare c1 cursor read_only for 
	select p.simID, p.dtID, p.table_name, p.prop_name, p.prop_value 
	from dbo.semserv_records p 

	open c1
			
	fetch next from c1 into @simID, @dtID, @table_name, @prop_name, @prop_value
	
	while @@FETCH_STATUS = 0
	begin
		
		SELECT @cnt = count(*) from INFORMATION_SCHEMA.TABLES where TABLE_NAME like @table_name
		
		if @cnt > 0 -- table exists
		begin
			
			SET @fparam = N'SELECT @cnt=COUNT(*) FROM ' + @table_name + ' WHERE simID = ' + cast(@simID as nvarchar(max))
			
			BEGIN TRY
			
				EXEC sp_executesql @fparam, N'@cnt int output', @cnt output;
				
				if @cnt = 0 -- record not exists, insert
				begin
					SET @fparam = N'INSERT INTO ' + @table_name + N' (simID,dtID) VALUES (' + cast(@simID as nvarchar(max)) + ',' + cast(@dtID as nvarchar(max)) + N')'
					EXEC sp_executesql @fparam
				end
				
				-- update record
				SET @fparam = N'UPDATE ' + @table_name + N' SET ' + @prop_name + N' = ''' + @prop_value + N''', dtID = ' + cast(@dtID as nvarchar(max)) + ' WHERE simID = ' + cast(@simID as nvarchar(max))
				EXEC sp_executesql @fparam
				
			END TRY
			BEGIN CATCH
				INSERT INTO dbo.simserv_errors (tableName, errorText) VALUES (@table_name, @fparam)
			END CATCH
                    
			

		end
	
		fetch next from c1 into @simID, @dtID, @table_name, @prop_name, @prop_value
	end
	
	close c1
	deallocate c1
	
	-- clear
	DELETE FROM dbo.semserv_records
	
	DBCC CHECKIDENT ('dbo.semserv_records')


END

--exec aecosim.[dbo].proc_i_ProcessRecords 0,0
GO
