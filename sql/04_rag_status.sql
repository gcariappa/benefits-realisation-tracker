-- 04 | Which benefits are on track against their planned trajectory?
-- Why it matters: Compares each benefit's latest actual with what the plan expected by that month, and gives a RAG status for programme reporting.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- Step 1: each benefit's most recent reported month
WITH last AS (
    SELECT benefit_id,
           MAX(period_month) AS latest_month
    FROM benefit_actuals
    GROUP BY benefit_id
),
-- Step 2: % of the PLANNED improvement achieved by that month
progress AS (
    SELECT b.benefit_id,
           b.benefit_name,
           (a.actual_value - b.baseline_value) * 100.0
             / (p.planned_value - b.baseline_value) AS pct_of_plan
    FROM benefits b
    JOIN last l
      ON l.benefit_id = b.benefit_id
    JOIN benefit_actuals a
      ON a.benefit_id = l.benefit_id
     AND a.period_month = l.latest_month
    JOIN benefit_plan p
      ON p.benefit_id = a.benefit_id
     AND p.period_month = a.period_month
    WHERE b.is_disbenefit = 0
)
-- Step 3: RAG thresholds: Green 90%+, Amber 70-90%, Red below 70%
SELECT benefit_id,
       benefit_name,
       ROUND(pct_of_plan, 1) AS pct_of_plan,
       CASE WHEN pct_of_plan >= 90 THEN 'Green'
            WHEN pct_of_plan >= 70 THEN 'Amber'
            ELSE 'Red'
       END AS rag
FROM progress
ORDER BY pct_of_plan;
