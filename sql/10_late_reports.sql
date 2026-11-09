-- 10 | Which benefit reports were late, and by how many days?
-- Why it matters: Measures reporting discipline against the deadline (10th of the following month).
-- Database: SQLite. Tables are described in docs/data_dictionary.md.

-- Due date = 10th of the month after the period: date(period_month, '+1 month', '+9 days')
SELECT benefit_id,
       period_month,
       reported_date,
       CAST(julianday(reported_date)
            - julianday(date(period_month, '+1 month', '+9 days')) AS INTEGER) AS days_late
FROM benefit_actuals
WHERE reported_date > date(period_month, '+1 month', '+9 days')
ORDER BY days_late DESC;
