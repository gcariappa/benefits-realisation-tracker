-- 03 | How much of each benefit has been realised so far?
-- Why it matters: Measures progress from baseline to target, so sponsors can see which benefits are close to done.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- Step 1: each benefit's most recent reported month
WITH last AS (
    SELECT benefit_id,
           MAX(period_month) AS latest_month
    FROM benefit_actuals
    GROUP BY benefit_id
)
-- Step 2: % of the journey from baseline to target achieved.
-- (actual - baseline) / (target - baseline) works for measures that should go up or down.
SELECT b.benefit_id,
       l.latest_month,
       a.actual_value AS latest_actual,
       ROUND((a.actual_value - b.baseline_value) * 100.0
             / (b.target_value - b.baseline_value), 1) AS pct_realised
FROM benefits b
JOIN last l
  ON l.benefit_id = b.benefit_id
JOIN benefit_actuals a
  ON a.benefit_id = l.benefit_id
 AND a.period_month = l.latest_month
WHERE b.is_disbenefit = 0          -- dis-benefits are tracked separately (query 08)
ORDER BY b.benefit_id;
