# SIC Benchmarks – SQL Server Security Best Practices

This directory contains a set of SQL queries crafted to help assess and enhance your SQL Server instance security in alignment with CIS Benchmarks and security best practices. The queries are grouped into areas corresponding to key security control domains.

## Directory Structure and Content

- **2. Surface Area Reduction**
  - *(Content could not be retrieved)*  
  Typically includes queries to minimize the SQL Server feature set, disable unused features/services, and reduce the potential attack surface.

- **3. Authentication and Authorization**
  - [3.1 Server Authentication is Windows.sql](./3.%20Authentication%20and%20Authorization/3.1%20Server%20Authentication%20is%20Windows.sql): Checks whether Windows Authentication mode is enforced.
  - [3.2 No 'guest' CONNECT permissions.sql](./3.%20Authentication%20and%20Authorization/3.2%20No%20'guest'%20CONNECT%20permissions.sql): Identifies databases where the 'guest' user has access, which should be restricted.
  - [3.3 Orphaned Users With Possible Logins.sql](./3.%20Authentication%20and%20Authorization/3.3%20Orphaned%20Users%20With%20Possible%20Logins.sql): Finds orphaned DB users with matching server logins.
  - [3.3 Orphaned Users.sql](./3.%20Authentication%20and%20Authorization/3.3%20Orphaned%20Users.sql): Detects users in databases without corresponding logins.
  - [3.4 SQL Authentication is not used in contained databases.sql](./3.%20Authentication%20and%20Authorization/3.4%20SQL%20Authentication%20is%20not%20used%20in%20contained%20databases.sql): Checks for SQL Auth in contained DBs.
  - [3.8 default permissions granted to the public server role.sql](./3.%20Authentication%20and%20Authorization/3.8%20default%20permissions%20granted%20to%20the%20public%20server%20role.sql): Lists default permissions held by the public role.
  - [3.9 Windows BUILTIN groups are not SQL Logins.sql](./3.%20Authentication%20and%20Authorization/3.9%20Windows%20BUILTIN%20groups%20are%20not%20SQL%20Logins.sql): Checks removal of BUILTIN groups from logins.
  - [3.10 Windows local groups are not SQL Logins.sql](./3.%20Authentication%20and%20Authorization/3.10%20Windows%20local%20groups%20are%20not%20SQL%20Logins.sql): Ensures no local Windows groups exist as logins.
  - [3.11 Public role in the msdb not granted access to SQL Agent proxies.sql](./3.%20Authentication%20and%20Authorization/3.11%20Public%20role%20in%20the%20msdb%20not%20granted%20access%20to%20SQL%20Agent%20proxies.sql): Ensures the msdb public role doesn't have SQL Agent proxy access.

- **4. Password Policies**
  - [4.2 'CHECK_EXPIRATION' is 'ON' for Sysadmin Role Logins.sql](./4.%20Password%20Policies/4.2%20'CHECK_EXPIRATION'%20is%20'ON'%20for%20Sysadmin%20Role%20Logins.sql): Checks password expiration for sysadmin logins.
  - [4.3 'CHECK_POLICY' is 'ON' for All SQL Authenticated Logins.sql](./4.%20Password%20Policies/4.3%20'CHECK_POLICY'%20is%20'ON'%20for%20All%20SQL%20Authenticated%20Logins.sql): Ensures password policies are enforced for all SQL-authenticated logins.

- **5. Auditing and Logging**
  - [5.1 Number of error log files is greater than 12.sql](./5.%20Auditing%20and%20Logging/5.1%20Number%20of%20error%20log%20files%20is%20greater%20than%2012.sql): Checks error log retention best practice.
  - [5.2 Default Trace Enabled.sql](./5.%20Auditing%20and%20Logging/5.2%20Default%20Trace%20Enabled.sql): Verifies that SQL default trace is enabled.
  - [5.3 Login Auditing is set to 'failed logins'.sql](./5.%20Auditing%20and%20Logging/5.3%20Login%20Auditing%20is%20set%20to%20'failed%20logins'.sql): Ensures auditing of failed logins.
  - [5.4 SQL Server Audit capture both 'failed' and Success Logins.sql](./5.%20Auditing%20and%20Logging/5.4%20SQL%20Server%20Audit%20capture%20both%20'failed'%20and%20Success%20Logins.sql): SQL Server Audit configuration for login events.

- **6. Application Development**
  - [6.2 CLR Assembly Permission is set to 'SAFE_ACCESS'.sql](./6.%20Application%20Development/6.2%20CLR%20Assembly%20Permission%20is%20set%20to%20'SAFE_ACCESS'.sql): Ensures that CLR assemblies have restricted (SAFE) permissions.

- **7. Encryption**
  - [7.1 Symmetric Key encryption algorithm is 'AES_128' or higher non system databases.sql](./7.%20Encryption/7.1%20Symmetric%20Key%20encryption%20algorithm%20is%20'AES_128'%20or%20higher%20non%20system%20databases.sql): Checks if non-system DBs use strong AES encryption.
  - [7.2 Asymmetric Key Size is greater than or equal to 2048 in non-system databases.sql](./7.%20Encryption/7.2%20Asymmetric%20Key%20Size%20is%20greater%20than%20or%20equal%20to%202048%20in%20non-system%20databases.sql): Validates DB keys meet minimum key size.

## Usage

Each script is intended to be run by a user with sufficient privileges to collect security configuration details (typically with VIEW SERVER STATE or higher).  
To use a script:
1. Open the desired `.sql` file.
2. Connect to your SQL Server (Management Studio or any SQL client).
3. Execute the script to review results and remediation actions as suggested.

## Disclaimer

- Review each script before running, as these are intended for auditing only—no modifications are made to your environment.
- The queries are provided as practical examples based on the CIS Benchmark guidelines. They may require adaptation to specific versions or environments.

---

*Original short readme:*
> 36 of CIS benchmark Queries   
> Covering some of CIS Surface Area Reduction, Authentication, Authorization, Password Policies, ...  
> and others
