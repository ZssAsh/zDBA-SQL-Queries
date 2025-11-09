/*
Script: 007_FailedLogin24h.sql
Author: Ziad Alashram

Purpose:
Extracts failed login attempts (error 18456) from the default trace in the last 24 hours.

Usage:
- Execute on SQL Instances (Group 1) only.

Output:
- Login name, application name, error message, and timestamp.
*/

SELECT 
	@@SERVERNAME as [Server Name],
	j.name 'Job',
	js.step_name,
	jh.sql_severity,
	jh.message,
	msdb.dbo.agent_datetime(jh.run_date, jh.run_time) RunTime
FROM msdb.dbo.sysjobs AS j
INNER JOIN msdb.dbo.sysjobsteps AS js ON js.job_id = j.job_id
INNER JOIN msdb.dbo.sysjobhistory AS jh ON jh.job_id = j.job_id
WHERE 
		jh.run_status = 0
	AND msdb.dbo.agent_datetime(jh.run_date, jh.run_time) > GETDATE() - 1
ORDER BY msdb.dbo.agent_datetime(jh.run_date, jh.run_time) DESC;