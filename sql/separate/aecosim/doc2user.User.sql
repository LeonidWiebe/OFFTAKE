CREATE USER [doc2user] FOR LOGIN [doc2user] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'doc2user'
GO
