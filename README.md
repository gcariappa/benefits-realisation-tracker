# Benefits Realisation Tracker

SQL and Power BI analysis of a simulated university transformation programme. It tracks whether four change projects are delivering the benefits they promised, from when each benefit is first identified through to full realisation.

> **About the data:** all data is simulated for a fictional university. It is shaped like a real benefits register, including realistic data-quality problems. I built this project while developing my SQL skills.

## The business problem
(Two or three sentences in your own words: what a programme board needs to know about benefits, and why it's hard to see.)

## The programme

| Project | Go-live | Benefits | Dis-benefits |
| --- | --- | --- | --- |
| Online Enquiries Portal | Feb 2026 | 3 | 1 |
| Automated Timetabling | May 2026 | 3 | 1 |
| Digital Assessment Submission | Aug 2026 | 3 | 1 |
| Staff Onboarding Workflow | Jan 2027 (in delivery) | 3 | 0 |

## Data model
Seven tables: the benefits register, lifecycle stage history, monthly plan and actuals, risks, and an as-is → to-be impact assessment. See the [data dictionary and data map](docs/data_dictionary.md).

## Questions answered

| # | Sponsor question | Query |
| --- | --- | --- |
| 01 | What stage of the lifecycle is each benefit at? | [01_benefits_register.sql](sql/01_benefits_register.sql) |
| 02 | How many benefits are at each lifecycle stage? | [02_lifecycle_pipeline.sql](sql/02_lifecycle_pipeline.sql) |
| 03 | How much of each benefit has been realised? | [03_realisation_to_date.sql](sql/03_realisation_to_date.sql) |
| 04 | Which benefits are on track against plan (RAG)? | [04_rag_status.sql](sql/04_rag_status.sql) |
| 05 | Which open risks most threaten benefits? | [05_sponsor_risk_view.sql](sql/05_sponsor_risk_view.sql) |
| 06 | Are cashable savings tracking to plan each month? | [06_cashable_savings_trend.sql](sql/06_cashable_savings_trend.sql) |
| 07 | What is the net cashable benefit after dis-benefit costs? | [07_net_cashable_benefit.sql](sql/07_net_cashable_benefit.sql) |
| 08 | Are any dis-benefits over tolerance? | [08_disbenefits_tolerance.sql](sql/08_disbenefits_tolerance.sql) |
| 09 | Where are benefit reports missing? | [09_missing_reports.sql](sql/09_missing_reports.sql) |
| 10 | Which reports were late, and by how much? | [10_late_reports.sql](sql/10_late_reports.sql) |
| 11 | Which stakeholder groups are most affected by the change? | [11_impact_assessment_summary.sql](sql/11_impact_assessment_summary.sql) |

## Key findings
(Your three to five findings, each with a number.)

## Dashboard
(Screenshots from the `dashboard` folder.)

## Recommendations
(Summarise; the full version is in the [sponsor report](report/sponsor_report.md).)

## How to reproduce
1. Install [DB Browser for SQLite](https://sqlitebrowser.org/) (free).
2. Create a new database and run [`sql/00_create_tables.sql`](sql/00_create_tables.sql).
3. Import each CSV in `data/` into the table with the same name (File → Import → Table from CSV file).
4. Run any query in `sql/`.

## Tools
SQL (SQLite) · Power BI · Excel

## About me
Gana Cariappa: sports scientist and analyst in London. MSc Human and Applied Physiology, King's College London. [LinkedIn](LINKEDIN_URL)
