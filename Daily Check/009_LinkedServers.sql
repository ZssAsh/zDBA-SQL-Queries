/*
Script: 009_LinkedServers.sql
Author: Ziad Alashram

Purpose:
Tests connectivity to all linked servers defined on the instance using sp_testlinkedserver.

Usage:
- Execute on SQL Instances (Group 1) only.

Output:
- Linked server name and connectivity status (Success/Failure).
*/

USE master;  
GO


DECLARE 
	@ServerName SYSNAME,
	@CheckResult bit

DECLARE @tmp TABLE (LS_ServerName varchar(50), IsSuccess bit)


DECLARE LS_Cursor CURSOR FOR
SELECT 
  name
FROM sys.servers
WHERE is_linked = 1

OPEN LS_Cursor
FETCH NEXT FROM LS_Cursor INTO @ServerName
WHILE @@FETCH_STATUS =0
BEGIN 
	--Print @ServerName
	BEGIN TRY
		EXEC sp_testlinkedserver @ServerName;  
		INSERT INTO  @tmp VALUES (CAST(@ServerName as VARCHAR(30)),1)
	END TRY

	BEGIN CATCH
		INSERT INTO  @tmp VALUES (CAST(@ServerName as VARCHAR(30)),0)
	END CATCH
	
	FETCH NEXT FROM LS_Cursor INTO @ServerName
END
CLOSE LS_Cursor
DEALLOCATE LS_Cursor

SELECT * FROM @tmp