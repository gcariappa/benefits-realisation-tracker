-- Creates the seven tables. Then import each CSV in /data into the table of the same name.
-- Written for SQLite (e.g. DB Browser for SQLite). Works in PostgreSQL or SQL Server with minor type changes.

CREATE TABLE projects (project_id TEXT PRIMARY KEY, project_name TEXT, senior_sponsor TEXT, project_manager TEXT,
  start_date TEXT, go_live_date TEXT, delivery_status TEXT);

CREATE TABLE benefits (benefit_id TEXT PRIMARY KEY, project_id TEXT, benefit_name TEXT, benefit_type TEXT,
  is_disbenefit INTEGER, benefit_owner TEXT, unit TEXT, desired_direction TEXT,
  baseline_value REAL, target_value REAL, target_date TEXT);

CREATE TABLE benefit_stage_history (benefit_id TEXT, stage TEXT, stage_date TEXT, recorded_by TEXT);

CREATE TABLE benefit_plan (benefit_id TEXT, period_month TEXT, planned_value REAL);

CREATE TABLE benefit_actuals (benefit_id TEXT, period_month TEXT, actual_value REAL, reported_date TEXT);

CREATE TABLE benefit_risks (risk_id TEXT PRIMARY KEY, benefit_id TEXT, raised_date TEXT, risk_description TEXT,
  likelihood INTEGER, impact INTEGER, risk_status TEXT, risk_owner TEXT);

CREATE TABLE impact_assessment (impact_id TEXT PRIMARY KEY, project_id TEXT, change_area TEXT, as_is TEXT, to_be TEXT,
  impacted_group TEXT, impact_level TEXT);
