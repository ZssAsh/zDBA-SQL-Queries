/*
Script: 010_Last CheckDB.sql
Author: Ziad Alashram

Purpose:
Reports the last DBCC CHECKDB run per database and any errors encountered.

Usage:
- Execute on SQL Instances (Group 1) only.

Output:
- Database name, state, last CHECKDB time, days since last run, error number, and message.
*/

WITH CHECKDB_Log AS
(
	SELECT 
		DatabaseName,
		t.StartTime,
		t.ErrorNumber,
		t.ErrorMessage
	FROM
	(
		SELECT 
			DatabaseName,
			ErrorNumber,
			starttime,
			endtime,
			ErrorMessage, 
			RANK() OVER (PARTITION BY CommandType ORDER BY CONVERT(DATE,starttime)  DESC) AS RANK
		FROM master.[dbo].[CommandLog] 
		WHERE CommandType='DBCC_CHECKDB'
	) t
	RIGHT JOIN sys.databases db ON db.name =  t.DatabaseName 
	WHERE t.rank=1
)

SELECT 	
	db.name,
	db.state_desc,
	CHECKDB_Log.StartTime,
	DATEDIFF(DAY,CONVERT(DATE,CHECKDB_Log.StartTime),CONVERT(DATE,GETDATE())) AS [Days],
	CHECKDB_Log.ErrorNumber,
	CHECKDB_Log.ErrorMessage 
FROM CHECKDB_Log
RIGHT JOIN sys.databases db ON db.name =  CHECKDB_Log.DatabaseName
WHERE db.name <> 'tempdb'
ORDER BY CHECKDB_Log.StartTime