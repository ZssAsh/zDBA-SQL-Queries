/*
Script: 001_PrimaryNodes.sql
Author: Ziad Alashram

Purpose:
Checks whether the current node is the PRIMARY replica in an Always On Availability Group.

Usage:
- Execute on each HA Node.
- Used to conditionally trigger actions only on the PRIMARY node.

Output:
- 'PRIMARY' if the node is the primary replica.
- 'NOT PRIMARY' otherwise.
*/

IF EXISTS (
    SELECT ars.role
    FROM sys.dm_hadr_availability_replica_states AS ars
    JOIN sys.availability_groups AS ag
        ON ars.group_id = ag.group_id
    WHERE ars.role_desc = 'PRIMARY'
)
BEGIN
    SELECT 'PRIMARY' AS [IsPrimary];
END
ELSE
BEGIN
    SELECT 'NOT PRIMARY' AS [IsPrimary];
END
