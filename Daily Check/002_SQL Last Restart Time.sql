/*
Script: 002_SQL Last Restart Time.sql
Author: Ziad Alashram

Purpose:
Retrieves the SQL Server instance's last restart time and calculates how many days have passed since.

Usage:
- Execute on all SQL Instances (Group 1) and HA Nodes (Group 2).

Output:
- Server name, restart timestamp, and days since last restart.
*/

SELECT 
	@@SERVERNAME AS ServerName, 
	CONVERT(CHAR(10), sqlserver_start_time, 101) + ' ' + CONVERT(CHAR(5), sqlserver_start_time, 108) AS Restarted_On, 
	DATEDIFF(DAY, sqlserver_start_time, GETDATE()) AS DateDiff
FROM sys.dm_os_sys_info; 