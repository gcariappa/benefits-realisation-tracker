-- 07 | What is the net cashable benefit to date once dis-benefit costs are counted?
-- Why it matters: Gives the honest financial position: savings minus the new costs the change created.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- CASE inside SUM adds up only the rows that fit each column.
SELECT ROUND(SUM(CASE WHEN b.is_disbenefit = 0
                      THEN b.baseline_value - a.actual_value ELSE 0 END), 0) AS gross_savings,
       ROUND(SUM(CASE WHEN b.is_disbenefit = 1
                      THEN a.actual_value ELSE 0 END), 0)                    AS disbenefit_cost,
       ROUND(SUM(CASE WHEN b.is_disbenefit = 0
                      THEN b.baseline_value - a.actual_value
                      ELSE -a.actual_value END), 0)                          AS net_benefit
FROM benefit_actuals a
JOIN benefits b
  ON b.benefit_id = a.benefit_id
WHERE b.benefit_type = 'Cashable';
