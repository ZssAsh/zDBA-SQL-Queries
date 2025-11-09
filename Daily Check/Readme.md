# 🧠 SQL Server Daily Health Check – Central Management Routine

This repository contains a curated set of SQL Server scripts used for daily health checks across two groups of servers managed via SQL Server Management Studio (SSMS) Central Management Server (CMS):

- **Group 1 – SQL Instances**: All standalone or clustered SQL Server instances.
- **Group 2 – HA Nodes**: Individual nodes participating in Always On Availability Groups (AGs).

---

## 🗂 Execution Matrix

| Script ID | Script Name                  | Group 1 (SQL Instances) | Group 2 (HA Nodes) |
|-----------|------------------------------|--------------------------|--------------------|
| 001       | Primary Node Check           | ❌                       | ✅                 |
| 002       | SQL Server Restart Time      | ✅                       | ✅                 |
| 003       | TempDB File Sizes            | ✅                       | ✅                 |
| 004       | Disk Free Space              | ✅                       | ✅                 |
| 005       | AG Dashboard                 | ✅                       | ❌                 |
| 006       | Database Mirroring Status    | ✅                       | ❌                 |
| 007       | Failed Logins (Last 24h)     | ✅                       | ❌                 |
| 008       | Failed Jobs (Last 24h)       | ✅                       | ❌                 |
| 009       | Linked Server Connectivity   | ✅                       | ❌                 |
| 010       | Last DBCC CHECKDB Run        | ✅                       | ❌                 |
| 011       | Last Full Backup             | ✅                       | ❌                 |
| 012       | Last Log Backup              | ✅                       | ❌                 |

---

## 📜 Script Descriptions

### 001_PrimaryNodes.sql
Checks if the current node is the **PRIMARY replica** in an Always On Availability Group. Used to conditionally execute tasks only on the primary node.

---

### 002_SQL Last Restart Time.sql
Returns the SQL Server instance's **last restart time** and how many days have passed since. Useful for detecting unexpected reboots or patching cycles.

---

### 003_TempFiles.sql
Reports **TempDB file sizes** (data and log) for the system database. Helps ensure TempDB is properly sized and balanced across files.

---

### 004_HDD Free Space.sql
Displays **disk space usage** per volume, including total space, free space, and a health indicator (`Low`, `Warning`, `Above 50%`). Useful for proactive storage monitoring.

---

### 005_AG Dashboard.sql
Generates a detailed **Availability Group health dashboard**, including:
- Replica roles
- Synchronization state
- Estimated data loss and recovery time
- Failover readiness

Use this to validate AG health and detect lagging secondaries.

---

### 006_MirroringStatus.sql
Lists databases involved in **Database Mirroring**, showing role (Principal/Mirror), state, and partner instance. Useful for legacy HA setups.

---

### 007_FailedLogin24h.sql
Extracts **failed login attempts** (error 18456) from the default trace in the last 24 hours. Helps detect unauthorized access attempts or misconfigured apps.

---

### 008_FailedJobs24h.sql
Lists **SQL Agent job failures** in the past 24 hours, including job name, step, severity, and error message. Critical for ensuring scheduled tasks are running successfully.

---

### 009_LinkedServers.sql
Tests connectivity to all **linked servers** defined on the instance using `sp_testlinkedserver`. Flags any unreachable servers.

---

### 010_Last CheckDB.sql
Reports the **last successful DBCC CHECKDB** run per database, including error messages if any. Helps ensure database integrity checks are being performed regularly.

---

### 011_Backup_Full.sql
Displays the **last full backup** date for each database, backup type, and device path. Highlights databases missing recent full backups.

---

### 012_Backup_Log.sql
Shows the **last log backup** per database. Useful for monitoring log backup chains, especially for databases in full recovery mode.

---

## ✅ Best Practices

- Run Group 2 scripts (001–004) on **each HA node** to capture node-level metrics.
- Run Group 1 scripts (002–012) on **each SQL instance** to capture instance-level health.
- Automate via CMS policies or PowerShell for consistency.
- Review output daily and escalate anomalies (e.g., failed jobs, missing backups, low disk space).

---

