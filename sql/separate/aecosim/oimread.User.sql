CREATE USER [oimread] FOR LOGIN [oimread] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'oimread'
GO
