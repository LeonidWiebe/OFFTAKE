CREATE USER [spbaep\a_pokul] FOR LOGIN [SPBAEP\a_pokul] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'spbaep\a_pokul'
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'spbaep\a_pokul'
GO
sys.sp_addrolemember @rolename = N'db_datawriter', @membername = N'spbaep\a_pokul'
GO
