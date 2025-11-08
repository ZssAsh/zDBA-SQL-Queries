Create Table #TempTable
(
	DBName VARCHAR(150),
	name VARCHAR(150),
	permission_set_desc VARCHAR(255),
)


DECLARE @command varchar(4000)
SET @command =
'
USE [?]
SELECT 
	"?" AS DBName,
	name,
	permission_set_desc
FROM sys.assemblies
WHERE is_user_defined = 1;
'

INSERT INTO #TempTable EXEC sp_MSforeachdb @command


SELECT * FROM #TempTable

DROP TABLE #TempTable