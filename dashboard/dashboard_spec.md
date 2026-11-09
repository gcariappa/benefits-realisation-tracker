# Power BI dashboard spec

Build time is about 2–3 hours. Every visual uses a CSV from the `results` folder: Get data → Text/CSV, then load each file you need. No joins are needed in Power BI, because the SQL has already done that work.

Use one consistent colour for each RAG status (Green, Amber, Red) across all pages, and keep everything else neutral.

## Page 1: Programme overview

**Question it answers:** are we getting the benefits we promised?

| Visual | Source | Set-up |
| --- | --- | --- |
| 4 cards across the top | `07_net_cashable_benefit`, `04_rag_status` | Net benefit to date (£), gross savings (£), number of Red benefits, number of Green benefits |
| Bar chart: % of plan by benefit | `04_rag_status` | Y axis benefit_name, X axis pct_of_plan, colour by rag, sorted ascending. Add a constant line at 100. |
| Funnel or bar chart: lifecycle pipeline | `02_lifecycle_pipeline` | current_stage in lifecycle order, value benefits |
| Table: benefits register | `01_benefits_register` | All columns, with a slicer on project_name |

## Page 2: Trends and risks

**Question it answers:** where is it going, and what could stop it?

| Visual | Source | Set-up |
| --- | --- | --- |
| Line chart: monthly cashable saving | `06_cashable_savings_trend` | X axis period_month, two lines: planned_saving (dashed) and actual_saving |
| Table: high open risks | `05_sponsor_risk_view` | project_name, benefit_name, risk_description, risk_score, with conditional formatting on score |
| Bar chart: % realised to date | `03_realisation_to_date` | benefit_id, pct_realised |

## Page 3: Dis-benefits and data quality

**Question it answers:** what side effects and data gaps should sponsors know about?

| Visual | Source | Set-up |
| --- | --- | --- |
| Clustered bar: dis-benefits against tolerance | `08_disbenefits_tolerance` | benefit_name, latest_actual vs tolerance, with the over-tolerance one highlighted |
| Table: missing reports | `09_missing_reports` | benefit_id, period_month |
| Table: late reports | `10_late_reports` | benefit_id, period_month, days_late |
| Matrix: change impact by group | `11_impact_assessment_summary` | impacted_group, high, medium, low, with a heat-map background |

## Finish

- Give each page a title that states the finding, not the topic: for example "4 of 9 benefits are behind plan", not "RAG status".
- Export each page as a PNG and upload it to this folder as `01_programme_overview.png`, `02_trends_and_risks.png` and `03_disbenefits_and_data_quality.png`.
- Upload the `.pbix` file here too.
