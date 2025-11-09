-- Temp table for extended properties
IF OBJECT_ID('tempdb..#ExtendedProps') IS NOT NULL DROP TABLE #ExtendedProps;
CREATE TABLE #ExtendedProps (
    DatabaseName NVARCHAR(128),
    PropertyName NVARCHAR(128),
    PropertyValue NVARCHAR(256)
);

-- Collect extended properties from all user databases
EXEC sp_MSforeachdb N'
IF ''?'' NOT IN (''master'', ''model'', ''msdb'', ''tempdb'')
BEGIN
    USE [?];
    INSERT INTO #ExtendedProps
    SELECT 
        DB_NAME() AS DatabaseName,
        ep.name,
        CAST(ep.value AS NVARCHAR(256))
    FROM sys.extended_properties ep
    WHERE ep.class = 0
      AND ep.name IN (
            ''CustodianName'',
            ''BusinessOwner'',
            ''TechnicalOwner'',
            ''Department'',
            ''DatabasePurpose'',
            ''DataSensitivity'',
            ''IsVendorDatabase'',
            ''ServiceRequestNumber'',
            ''PrimaryApplication'',
            ''LinkedSystems''
      );
END
';

-- Get current SQL Server version and collation
DECLARE @CurrentCompatLevel INT = CAST(SERVERPROPERTY('ProductMajorVersion') AS INT) * 10;
DECLARE @ServerCollation NVARCHAR(128) = CAST(SERVERPROPERTY('Collation') AS NVARCHAR(128));

-- Final catalog output
SELECT 
    d.name AS [Database Name],
    d.create_date AS [Create Date],
    d.compatibility_level AS [Compatibility Level],
    CASE 
        WHEN d.compatibility_level = @CurrentCompatLevel 
        THEN 'Yes' ELSE 'No' 
    END AS [Match Server Level],
    d.collation_name AS [Collation Name],
    CASE 
        WHEN d.collation_name = @ServerCollation 
        THEN 'Yes' ELSE 'No' 
    END AS [Match Server Collation],
    d.state_desc AS [State],
    d.recovery_model_desc AS [Recovery Model],
    d.is_encrypted AS [Is Encrypted],
    -- Extended properties
    MAX(CASE WHEN ep.PropertyName = 'CustodianName' THEN ep.PropertyValue END) AS [Custodian Name],
    MAX(CASE WHEN ep.PropertyName = 'BusinessOwner' THEN ep.PropertyValue END) AS [Business Owner],
    MAX(CASE WHEN ep.PropertyName = 'TechnicalOwner' THEN ep.PropertyValue END) AS [Technical Owner],
    MAX(CASE WHEN ep.PropertyName = 'Department' THEN ep.PropertyValue END) AS [Department],
    MAX(CASE WHEN ep.PropertyName = 'DatabasePurpose' THEN ep.PropertyValue END) AS [Database Purpose],
    MAX(CASE WHEN ep.PropertyName = 'DataSensitivity' THEN ep.PropertyValue END) AS [Data Sensitivity],
    MAX(CASE WHEN ep.PropertyName = 'IsVendorDatabase' THEN ep.PropertyValue END) AS [Is Vendor Database],
    MAX(CASE WHEN ep.PropertyName = 'ServiceRequestNumber' THEN ep.PropertyValue END) AS [Service Request Number],
    MAX(CASE WHEN ep.PropertyName = 'PrimaryApplication' THEN ep.PropertyValue END) AS [Primary Application],
    MAX(CASE WHEN ep.PropertyName = 'LinkedSystems' THEN ep.PropertyValue END) AS [Linked Systems]

FROM sys.databases d
LEFT JOIN #ExtendedProps ep ON d.name = ep.DatabaseName
WHERE d.name NOT IN ('master', 'model', 'msdb', 'tempdb')
  AND d.state_desc = 'ONLINE'
GROUP BY 
    d.name, d.create_date, d.compatibility_level, 
    d.collation_name, d.state_desc, d.recovery_model_desc, d.is_encrypted
ORDER BY d.name; 
