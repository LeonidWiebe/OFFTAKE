RESTORE DATABASE [parts_srtm] FROM  DISK = N'D:\backup\parts.bak' WITH  FILE = 1,  MOVE N'parts' TO N'D:\data\parts_srtm.mdf',  MOVE N'parts_log' TO N'D:\data\parts_srtm_log.ldf',  NOUNLOAD,  REPLACE,  STATS = 10
GO
