CREATE USER [SP\MAGrigoriev] FOR LOGIN [SP\MAGrigoriev] WITH DEFAULT_SCHEMA=[dbo]
GO
sys.sp_addrolemember @rolename = N'db_owner', @membername = N'SP\MAGrigoriev'
GO
