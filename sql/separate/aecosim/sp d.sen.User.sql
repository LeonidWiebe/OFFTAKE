CREATE USER [sp\d.sen] FOR LOGIN [SP\d.sen] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'sp\d.sen'
GO
