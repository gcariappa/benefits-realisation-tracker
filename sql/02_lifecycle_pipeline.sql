-- 02 | How many benefits are at each lifecycle stage?
-- Why it matters: Shows the programme's benefits pipeline: how much is still being defined and how much is already being realised.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- Step 1: latest stage date per benefit
WITH latest AS (
    SELECT benefit_id,
           MAX(stage_date) AS last_date
    FROM benefit_stage_history
    GROUP BY benefit_id
),
-- Step 2: the current stage of each benefit
current_stage AS (
    SELECT h.benefit_id,
           h.stage
    FROM benefit_stage_history h
    JOIN latest l
      ON l.benefit_id = h.benefit_id
     AND h.stage_date = l.last_date
)
-- Step 3: count benefits per stage, in lifecycle order (not alphabetical)
SELECT stage AS current_stage,
       COUNT(*) AS benefits
FROM current_stage
GROUP BY stage
ORDER BY CASE stage
           WHEN 'Identified' THEN 1
           WHEN 'Defined'    THEN 2
           WHEN 'Planned'    THEN 3
           WHEN 'Realising'  THEN 4
           WHEN 'Realised'   THEN 5
         END;
