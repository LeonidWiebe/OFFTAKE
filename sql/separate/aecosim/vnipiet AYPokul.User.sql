CREATE USER [vnipiet\AYPokul] FOR LOGIN [VNIPIET\AYPokul] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'vnipiet\AYPokul'
GO
