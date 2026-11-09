-- 01 | What lifecycle stage is each benefit at, and who owns it?
-- Why it matters: Gives sponsors one register of every benefit, its project, its owner and where it sits between Identified and Realised.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- Step 1: find the date of each benefit's most recent stage change
WITH latest AS (
    SELECT benefit_id,
           MAX(stage_date) AS last_date
    FROM benefit_stage_history
    GROUP BY benefit_id
)
-- Step 2: join back to the history to get the stage name on that date,
-- then add the benefit and project details
SELECT b.benefit_id,
       b.benefit_name,
       p.project_name,
       b.benefit_owner,
       h.stage AS current_stage
FROM benefits b
JOIN projects p
  ON p.project_id = b.project_id
JOIN latest l
  ON l.benefit_id = b.benefit_id
JOIN benefit_stage_history h
  ON h.benefit_id = l.benefit_id
 AND h.stage_date = l.last_date
ORDER BY b.project_id, b.benefit_id;
