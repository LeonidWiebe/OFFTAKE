CREATE USER [SPBAEP\p_dikalov] FOR LOGIN [SPBAEP\p_dikalov] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'SPBAEP\p_dikalov'
GO
