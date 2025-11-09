/*
Script: 004_HDD Free Space.sql
Author: Ziad Alashram

Purpose:
Displays disk space usage per volume, including total space, free space, percentage free, and health status.

Usage:
- Execute on all SQL Instances (Group 1) and HA Nodes (Group 2).

Output:
- Logical volume name, mount point, total and free space in GB, percentage free, and status (Low/Warning/Healthy).
*/

SELECT DISTINCT 
	dovs.logical_volume_name AS LogicalName,
	dovs.volume_mount_point AS Drive,
	CONVERT(DECIMAL(10,2), dovs.total_bytes/(1024.0*1024.0*1024.0)) AS TotalSpaceInGB,
	CONVERT(DECIMAL(10,2), dovs.available_bytes/(1024.0*1024.0*1024.0)) AS FreeSpaceInGB,
	CONCAT(CONVERT(INT,(CONVERT(DECIMAL(10,2), dovs.available_bytes/(1024.0*1024.0*1024.0)) / CONVERT(DECIMAL(10,2), dovs.total_bytes/(1024.0*1024.0*1024.0)))*100),'%'),
CASE 
	WHEN CONVERT(INT,(CONVERT(DECIMAL(10,2), dovs.available_bytes/(1024.0*1024.0*1024.0)) / CONVERT(DECIMAL(10,2), dovs.total_bytes/(1024.0*1024.0*1024.0)))*100) < 50 THEN 'Low'
	WHEN CONVERT(INT,(CONVERT(DECIMAL(10,2), dovs.available_bytes/(1024.0*1024.0*1024.0)) / CONVERT(DECIMAL(10,2), dovs.total_bytes/(1024.0*1024.0*1024.0)))*100) < 55 THEN 'Warning'
	ELSE 'Above %50%'
END AS IsLow
FROM sys.master_files mf
CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.FILE_ID) dovs
ORDER BY FreeSpaceInGB ASC
GO