-- Switch to the target database
USE [<DatabaseName,sysname,Database>];  -- Replace with the actual database name
GO

-- Define required properties and default values
DECLARE @RequiredProperties TABLE (
    PropertyName NVARCHAR(128),
    PropertyValue NVARCHAR(256)
);

INSERT INTO @RequiredProperties (PropertyName, PropertyValue)
VALUES
    ('CustodianName', '<CustodianName,nvarchar(256),Not Assigned>'),
    ('BusinessOwner', '<BusinessOwner,nvarchar(256),Not Assigned>'),
    ('TechnicalOwner', '<TechnicalOwner,nvarchar(256),Not Assigned>'),
    ('Department', '<Department,nvarchar(256),Unspecified>'),
    ('DatabasePurpose', '<DatabasePurpose,nvarchar(256),Unspecified>'),
    ('DataSensitivity', '<DataSensitivity,nvarchar(256),Unclassified>'),
    ('IsVendorDatabase', '<IsVendorDatabase,nvarchar(256),No>'),
    ('ServiceRequestNumber', '<ServiceRequestNumber,nvarchar(256),None>'),
    ('PrimaryApplication', '<PrimaryApplication,nvarchar(256),Unlinked>'),
    ('LinkedSystems', '<LinkedSystems,nvarchar(256),None>')

-- Build and execute dynamic SQL for each property
DECLARE @SQL NVARCHAR(MAX) = N'';

SELECT @SQL = @SQL + '
IF EXISTS (
    SELECT 1 FROM sys.extended_properties 
    WHERE class = 0 AND name = N''' + PropertyName + '''
)
BEGIN
    EXEC sp_updateextendedproperty 
        @name = N''' + PropertyName + ''', 
        @value = N''' + PropertyValue + ''';
END
ELSE
BEGIN
    EXEC sp_addextendedproperty 
        @name = N''' + PropertyName + ''', 
        @value = N''' + PropertyValue + ''';
END;
'
FROM @RequiredProperties;

-- Execute all updates/additions
EXEC sp_executesql @SQL; 
