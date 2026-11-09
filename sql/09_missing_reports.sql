-- 09 | Which benefit reports are missing?
-- Why it matters: Finds months where a benefit was planned but never measured, so owners can be chased and the RAG view can be trusted.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- Every planned benefit-month should have an actual. LEFT JOIN keeps all plan rows;
-- where no actual matches, the actuals columns are NULL.
SELECT p.benefit_id,
       p.period_month
FROM benefit_plan p
LEFT JOIN benefit_actuals a
  ON a.benefit_id = p.benefit_id
 AND a.period_month = p.period_month
WHERE p.period_month <= '2026-09-01'   -- latest month due for reporting
  AND a.benefit_id IS NULL
ORDER BY p.period_month, p.benefit_id;
