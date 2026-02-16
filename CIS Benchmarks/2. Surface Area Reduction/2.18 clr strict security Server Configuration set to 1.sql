Create Table #TempTable
(
	DBName VARCHAR(150),
	Assembly_Name VARCHAR(200),
	permission_set_desc NVARCHAR(255),
)


DECLARE @command varchar(4000)
SET @command =
'
USE [?]
SELECT 
	"?" AS DBName,
	name AS Assembly_Name, permission_set_desc
FROM sys.assemblies
WHERE is_user_defined = 1;
'

INSERT INTO #TempTable EXEC sp_MSforeachdb @command

SELECT name,
CAST(value as int) as value_configured,
CAST(value_in_use as int) as value_in_use
FROM sys.configurations
WHERE name = 'clr strict security';

SELECT name,
CAST(value as int) as value_configured,
CAST(value_in_use as int) as value_in_use
FROM sys.configurations
WHERE name = 'clr enabled'

SELECT * FROM #TempTable

DROP TABLE #TempTable