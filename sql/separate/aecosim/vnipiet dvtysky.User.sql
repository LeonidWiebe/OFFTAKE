CREATE USER [vnipiet\dvtysky] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'vnipiet\dvtysky'
GO
