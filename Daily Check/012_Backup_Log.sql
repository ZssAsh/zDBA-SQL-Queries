/*
Script: 012_Backup_Log.sql
Author: Ziad Alashram

Purpose:
Displays the last log backup date and details for each database.

Usage:
- Execute on SQL Instances (Group 1) only.

Output:
- Database name, last log backup time, days since backup, recovery model, backup type, and device path.
*/

;WITH CTE_Backup AS
(
	SELECT  
		database_name
		,backup_start_date
		,type
		,physical_device_name
		,Row_Number() OVER(PARTITION BY database_name,BS.type ORDER BY backup_start_date DESC) AS RowNum
	FROM msdb..backupset BS
	JOIN msdb.dbo.backupmediafamily BMF ON BS.media_set_id=BMF.media_set_id
)
SELECT
	D.name
	,ISNULL(CONVERT(VARCHAR,backup_start_date),'1900-01-01 00:00:00.000') AS last_backup_time
	,DATEDIFF(DAY,backup_start_date,GETDATE()) AS DIFF_Days
	,D.recovery_model_desc
	,'Log' AS backup_type
	,physical_device_name
FROM sys.databases D
LEFT JOIN CTE_Backup CTE ON D.name = CTE.database_name AND RowNum = 1
WHERE 
		type ='L'
	AND d.state =0
ORDER BY D.name,type