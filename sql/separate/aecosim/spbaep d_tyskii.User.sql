CREATE USER [spbaep\d_tyskii] FOR LOGIN [SPBAEP\d_tyskii] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'spbaep\d_tyskii'
GO
