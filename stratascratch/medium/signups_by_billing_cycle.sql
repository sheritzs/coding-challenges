-- Write a query that returns a table containing the number of signups
-- for each weekday and for each billing cycle frequency. The day of 
-- the week standard we expect is from Sunday as 0 to Saturday as 6.

-- Output the weekday number (e.g., 1, 2, 3) as rows in your table and
-- the billing cycle frequency (e.g., annual, monthly, quarterly) as 
-- columns. If there are NULLs in the output replace them with zeroes.

SELECT 
    EXTRACT(DOW FROM s.signup_start_date) AS weekday,
    SUM(CASE p.billing_cycle 
        WHEN 'annual' THEN 1 ELSE 0 END) AS annual,
    SUM(CASE p.billing_cycle 
        WHEN 'monthly' THEN 1 ELSE 0 END) AS monthly,
    SUM(CASE p.billing_cycle 
        WHEN 'quarterly' THEN 1 ELSE 0 END) AS quarterly
FROM signups s JOIN plans p 
    ON s.plan_id = p.id
GROUP BY  EXTRACT(DOW FROM s.signup_start_date)
ORDER BY weekday
