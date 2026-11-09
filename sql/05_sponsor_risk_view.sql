-- 05 | Which open risks most threaten the programme's benefits?
-- Why it matters: Ranks open risks by score (likelihood x impact) so sponsors focus on the few that matter most.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

SELECT p.project_name,
       b.benefit_name,
       r.risk_description,
       r.likelihood * r.impact AS risk_score
FROM benefit_risks r
JOIN benefits b
  ON b.benefit_id = r.benefit_id
JOIN projects p
  ON p.project_id = b.project_id
WHERE r.risk_status = 'Open'
  AND r.likelihood * r.impact >= 12      -- 12+ = high on a 5 x 5 matrix
ORDER BY risk_score DESC, r.risk_id;
