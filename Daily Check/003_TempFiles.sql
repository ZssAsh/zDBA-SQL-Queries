/*
Script: 003_TempFiles.sql
Author: Ziad Alashram

Purpose:
Reports the current size of TempDB data and log files.

Usage:
- Execute on all SQL Instances (Group 1) and HA Nodes (Group 2).

Output:
- Database name, file type, file name, and size in MB.
*/

SELECT 
    DB_NAME(database_id) AS database_name, 
    type_desc, 
    name AS FileName, 
    size/128.0 AS CurrentSizeMB
FROM sys.master_files
WHERE database_id =2 AND type IN (0,1)