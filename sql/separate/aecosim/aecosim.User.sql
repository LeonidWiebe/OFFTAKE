CREATE USER [aecosim] FOR LOGIN [aecosim] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'aecosim'
GO
