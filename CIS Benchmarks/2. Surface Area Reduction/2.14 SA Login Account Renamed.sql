SELECT 
	name,
	case when name = 'sa' then 'False' else 'True' END AS isRenamed
FROM sys.server_principals
WHERE sid = 0x01;