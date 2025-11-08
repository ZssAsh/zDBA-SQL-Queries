SELECT 
	name, 
	is_disabled,
	is_policy_checked
FROM sys.sql_logins
WHERE is_policy_checked = 0;