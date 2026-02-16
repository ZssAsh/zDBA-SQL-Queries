Create Table #TempTable
(
	DatabaseName VARCHAR(150),
	Database_User VARCHAR(150),
	permission_name NVARCHAR(100),
	state_desc NVARCHAR(100)
)


DECLARE @command varchar(4000)
SET @command =
'
USE [?]
SELECT 
	DB_NAME() AS DatabaseName, 
	''guest'' AS Database_User,
	[permission_name], 
	[state_desc]
FROM sys.database_permissions
WHERE [grantee_principal_id] = DATABASE_PRINCIPAL_ID(''guest'')
AND [state_desc] LIKE ''GRANT%''
AND [permission_name] = ''CONNECT''
AND DB_NAME() NOT IN (''master'',''tempdb'',''msdb'');
'

INSERT INTO #TempTable EXEC sp_MSforeachdb @command

SELECT * FROM #TempTable

DROP TABLE #TempTable
