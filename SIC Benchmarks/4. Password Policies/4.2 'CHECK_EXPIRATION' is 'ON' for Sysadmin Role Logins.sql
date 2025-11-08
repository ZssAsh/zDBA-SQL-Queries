SELECT 
	l.[name], 
	'sysadmin membership' AS 'Access_Method',
	l.is_expiration_checked
FROM sys.sql_logins AS l
WHERE 
		IS_SRVROLEMEMBER('sysadmin',name) = 1
	AND l.is_expiration_checked <> 1
UNION ALL
SELECT 
	l.[name], 
	'CONTROL SERVER' AS 'Access_Method',
	l.is_expiration_checked
FROM sys.sql_logins AS l
	JOIN sys.server_permissions AS p ON l.principal_id = p.grantee_principal_id
WHERE 
		p.type = 'CL' 
	AND p.state IN ('G', 'W')
	AND l.is_expiration_checked <> 1;