CREATE USER [so2user] FOR LOGIN [so2user] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'so2user'
GO
sys.sp_addrolemember @rolename = N'db_datawriter', @membername = N'so2user'
GO
