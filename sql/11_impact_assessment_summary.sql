-- 11 | Which stakeholder groups are most affected by the as-is to to-be changes?
-- Why it matters: Shows where change management effort is most needed, by counting high, medium and low impacts per group.
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- A pivot: one row per group, one column per impact level.
SELECT impacted_group,
       SUM(CASE WHEN impact_level = 'High'   THEN 1 ELSE 0 END) AS high,
       SUM(CASE WHEN impact_level = 'Medium' THEN 1 ELSE 0 END) AS medium,
       SUM(CASE WHEN impact_level = 'Low'    THEN 1 ELSE 0 END) AS low
FROM impact_assessment
GROUP BY impacted_group
ORDER BY high DESC, impacted_group;
