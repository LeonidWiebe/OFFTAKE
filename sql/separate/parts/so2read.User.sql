CREATE USER [so2read] FOR LOGIN [so2read] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_exec', @membername = N'so2read'
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'so2read'
GO
