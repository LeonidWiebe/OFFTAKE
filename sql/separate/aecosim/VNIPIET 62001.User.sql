CREATE USER [VNIPIET\62001] FOR LOGIN [VNIPIET\62001] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'VNIPIET\62001'
GO
