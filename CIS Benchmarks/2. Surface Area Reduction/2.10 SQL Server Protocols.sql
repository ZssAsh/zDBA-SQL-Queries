SELECT @@SERVERNAME,
(SELECT iif(value_data = 1, 'Yes', 'No') FROM sys.dm_server_registry WHERE registry_key LIKE '%tcp' AND value_name = 'Enabled') AS 'TCP/IP',
(SELECT iif(value_data = 1, 'Yes', 'No') FROM sys.dm_server_registry WHERE registry_key LIKE '%np' AND value_name = 'Enabled') AS 'Named Pipes',
(SELECT iif(value_data = 1, 'Yes', 'No') FROM sys.dm_server_registry WHERE registry_key LIKE '%sm' AND value_name = 'Enabled') AS 'Shared Memory'
