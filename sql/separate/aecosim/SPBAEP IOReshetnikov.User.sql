CREATE USER [SPBAEP\IOReshetnikov] FOR LOGIN [SPBAEP\IOReshetnikov] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'SPBAEP\IOReshetnikov'
GO
sys.sp_addrolemember @rolename = N'db_datawriter', @membername = N'SPBAEP\IOReshetnikov'
GO
