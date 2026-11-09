-- 08 | Are any dis-benefits over their agreed tolerance?
-- Why it matters: Flags negative side-effects of the change that have grown beyond what the programme agreed to accept.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- For dis-benefits, target_value holds the tolerance (the most that is acceptable).
WITH last AS (
    SELECT benefit_id,
           MAX(period_month) AS latest_month
    FROM benefit_actuals
    GROUP BY benefit_id
)
SELECT b.benefit_id,
       b.benefit_name,
       a.actual_value AS latest_actual,
       b.target_value AS tolerance,
       CASE WHEN a.actual_value > b.target_value THEN 'Over tolerance'
            ELSE 'Within tolerance'
       END AS status
FROM benefits b
JOIN last l
  ON l.benefit_id = b.benefit_id
JOIN benefit_actuals a
  ON a.benefit_id = l.benefit_id
 AND a.period_month = l.latest_month
WHERE b.is_disbenefit = 1
ORDER BY b.benefit_id;
