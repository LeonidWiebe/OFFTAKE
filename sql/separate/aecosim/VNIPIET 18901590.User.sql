CREATE USER [VNIPIET\18901590] FOR LOGIN [VNIPIET\18901590] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'VNIPIET\18901590'
GO
