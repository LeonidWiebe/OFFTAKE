RESTORE DATABASE [parts_bkp] FROM  DISK = N'D:\backup\parts.bak' WITH  FILE = 1,  MOVE N'parts' TO N'D:\data\parts_bkp.mdf',  MOVE N'parts_log' TO N'D:\data\parts_bkp_log.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO
