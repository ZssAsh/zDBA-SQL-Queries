Create Table #TempTable
(
	DBName VARCHAR(150),
	--ObjectID int,
	ObjName VARCHAR(150),
	ObjType NVARCHAR(50),
	xp_cmdshell_Enabled int
)


DECLARE @command varchar(4000)
SET @command =
'
USE [?]
SELECT 
	"?" AS DBName,
	--m.object_id,
	OBJECT_NAME(m.object_id),
	o.type_desc,
	(SELECT CAST(value_in_use as int) as value_in_use FROM sys.configurations WHERE name = ''xp_cmdshell'')
FROM sys.sql_modules m 
INNER JOIN sys.objects o ON m.object_id=o.object_id 
WHERE 
	m.definition LIKE ''%xp_CmdShell%''
	AND "?" <> ''msdb''

'

INSERT INTO #TempTable EXEC sp_MSforeachdb @command



SELECT name,
CAST(value as int) as value_configured,
CAST(value_in_use as int) as value_in_use
FROM sys.configurations
WHERE name = 'xp_cmdshell';


SELECT * FROM #TempTable

DROP TABLE #TempTable
