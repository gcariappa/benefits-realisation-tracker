-- 06 | Are cashable savings tracking to plan month by month?
-- Why it matters: Shows the monthly saving the programme planned against what it achieved, for finance and sponsors.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- Saving = baseline cost - value that month (planned or actual).
-- Only benefit-months with a reported actual are compared, so plan and actual cover the same benefits.
SELECT a.period_month,
       ROUND(SUM(b.baseline_value - p.planned_value), 0) AS planned_saving,
       ROUND(SUM(b.baseline_value - a.actual_value), 0)  AS actual_saving
FROM benefit_actuals a
JOIN benefit_plan p
  ON p.benefit_id = a.benefit_id
 AND p.period_month = a.period_month
JOIN benefits b
  ON b.benefit_id = a.benefit_id
WHERE b.benefit_type = 'Cashable'
  AND b.is_disbenefit = 0
GROUP BY a.period_month
ORDER BY a.period_month;
