RESTORE DATABASE [parts_bkp2] FROM  DISK = N'D:\backup\parts.bak' WITH  FILE = 1,  MOVE N'parts' TO N'D:\data\parts_bkp2.mdf',  MOVE N'parts_log' TO N'D:\data\parts_bkp2_log.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO
