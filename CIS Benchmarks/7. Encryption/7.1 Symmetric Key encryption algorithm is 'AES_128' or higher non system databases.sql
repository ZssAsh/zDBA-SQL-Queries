Create Table #TempTable
(
	DBName VARCHAR(150),
	name VARCHAR(150) 
)


DECLARE @command varchar(4000)
SET @command =
'
USE [?]
SELECT db_name() AS Database_Name, name AS Key_Name
FROM sys.symmetric_keys
WHERE algorithm_desc NOT IN (''AES_128'',''AES_192'',''AES_256'')
AND db_id() > 4;
'

INSERT INTO #TempTable EXEC sp_MSforeachdb @command


SELECT * FROM #TempTable

DROP TABLE #TempTable