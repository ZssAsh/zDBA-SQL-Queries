Use master
Go
Create Table #Orphans 
(
	RowID     int not null primary key identity(1,1) ,
	TDBName varchar (100),
	UserName varchar (100),
	UserSid varbinary(85),
	LoginName varchar (100),
	LoginSid varbinary(85)
)
SET NOCOUNT ON 
DECLARE @DBName sysname, @Qry nvarchar(4000)
SET @Qry = ''
SET @DBName = ''

DECLARE db_cursor CURSOR FOR
SELECT [Name] 
FROM sys.databases 
WHERE 
		[Name] NOT IN ('model','msdb','distribution')
	AND [state] =0
	AND [Name] NOT IN 
	(
		SELECT DISTINCT
			dbcs.database_name AS [DatabaseName]
		FROM master.sys.availability_groups AS AG
			LEFT OUTER JOIN master.sys.dm_hadr_availability_group_states as agstates ON AG.group_id = agstates.group_id
			INNER JOIN master.sys.availability_replicas AS AR ON AG.group_id = AR.group_id
			INNER JOIN master.sys.dm_hadr_availability_replica_states AS arstates ON AR.replica_id = arstates.replica_id AND arstates.is_local = 1
			INNER JOIN master.sys.dm_hadr_database_replica_cluster_states AS dbcs ON arstates.replica_id = dbcs.replica_id
			LEFT OUTER JOIN master.sys.dm_hadr_database_replica_states AS dbrs ON dbcs.replica_id = dbrs.replica_id AND dbcs.group_database_id = dbrs.group_database_id
		WHERE ISNULL(arstates.role, 3) = 2 AND ISNULL(dbcs.is_database_joined, 0) = 1
	)
OPEN db_cursor  
FETCH NEXT FROM db_cursor INTO @DBName 

WHILE @@FETCH_STATUS = 0
BEGIN 

	--SELECT @DBName
	Set @Qry = '
		select ''' + @DBName + ''' AS DBName, 
			a.name AS UserName, 
			a.sid AS UserSID,
			b.[name] AS LoginName,
			b.sid AS LoginSID
		from [' + @DBName + ']..sysusers a
			LEFT JOIN sys.syslogins b on a.name collate SQL_Latin1_General_CP1_CI_AS =  b.name
		where 
				a.issqluser = 1 
			and (a.sid is not null and a.sid <> 0x0) 
			and suser_sname(a.sid) is null order by a.name
			'
			
	Insert into #Orphans Exec (@Qry)
	
	FETCH NEXT FROM db_cursor INTO @DBName
END
CLOSE db_cursor  
DEALLOCATE db_cursor 

Select * from #Orphans

Drop table #Orphans