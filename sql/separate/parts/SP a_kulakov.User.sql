CREATE USER [SP\a_kulakov] FOR LOGIN [SP\a_kulakov] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_datareader', @membername = N'SP\a_kulakov'
GO
