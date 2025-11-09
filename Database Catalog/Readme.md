# zDBA-SQL-Queries

This repository is a living catalog of SQL Server queries used in my daily work as a Senior Database Administrator. It complements the onboarding and governance framework described in my [LinkedIn article](https://www.linkedin.com/pulse/building-smarter-sql-database-catalog-using-extended-ziad-alashram-dp6of), which outlines how to build smarter, auditable database catalogs using Extended Properties.

## 🎯 Purpose

The queries here are designed to:
- Automate and standardize routine DBA tasks
- Support onboarding, auditing, and compliance workflows
- Enhance visibility across environments using metadata-driven controls
- Serve as reusable building blocks for a scalable database acceptance framework

## 🧠 Strategic Foundation

Inspired by the principle of *“metadata as a control layer”*, this repository treats SQL queries not just as scripts—but as **auditable assets**. Many queries leverage Extended Properties to:
- Embed business context directly into database objects
- Track ownership, lifecycle stage, and onboarding status
- Enable dynamic reporting and governance

## 📁 Repository Structure

Queries are grouped by functional domain. Current categories include:

- `Security_Audit/` – login tracking, permission audits, role analysis
- `Performance_Monitoring/` – slow queries, blocking sessions, wait stats
- `Maintenance/` – index health, database size, backup status
- `Onboarding_Framework/` – Extended Properties, catalog builders, validation scripts

Each `.sql` file includes:
- Clear naming and purpose
- Inline comments for usage and customization
- Optional metadata tagging for catalog integration

## 🚀 How to Use

1. Clone or download the repository.
2. Open any `.sql` file in SSMS or Azure Data Studio.
3. Customize parameters (e.g., database name, object filters).
4. Run in a safe environment with appropriate permissions.

> ⚠️ Many queries assume SQL Server environments with Extended Properties enabled.

## 🔮 Future Roadmap

Planned additions include:
- Visual dashboards for catalog insights
- PowerShell and Azure CLI integrations
- Acceptance framework templates for onboarding new databases
- Metadata-driven automation scripts

## 🤝 Contributions & Collaboration

This repository reflects my personal workflow, but I welcome feedback and collaboration. Feel free to fork, star, or submit pull requests.

## 📬 Connect

For consulting, collaboration, or strategic discussions, reach out via:
- [LinkedIn](https://www.linkedin.com/in/ziadashram/)
- GitHub Issues

---

