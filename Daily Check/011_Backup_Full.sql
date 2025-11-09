/*
Script: 011_Backup_Full.sql
Author: Ziad Alashram

Purpose:
Displays the last full backup date and details for each database.

Usage:
- Execute on SQL Instances (Group 1) only.

Output:
- Database name, last backup time, days since backup, recovery model, backup type, and device path.
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
	,CASE 
		WHEN type ='D' THEN 'Full database'
		WHEN type ='I' THEN 'Differential database'
		WHEN type ='L' THEN 'Log'
		WHEN type ='F' THEN 'File or filegroup'
		WHEN type ='G' THEN 'Differential file'
		WHEN type ='P' THEN 'Partial'
		WHEN type ='Q' THEN 'Differential partial'
		ELSE 'Unknown' 
	END AS backup_type
	,physical_device_name
FROM sys.databases D
LEFT JOIN CTE_Backup CTE ON D.name = CTE.database_name AND RowNum = 1
WHERE 
		type ='D'
	AND d.state =0
ORDER BY    D.name,type