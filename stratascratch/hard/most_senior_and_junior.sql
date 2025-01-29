-- Write a query to find the number of days between the longest 
-- and least tenured employee still working for the company. 
-- Your output should include the number of employees with 
-- the longest-tenure, the number of employees with the 
-- least-tenure, and the number of days between both the 
-- longest-tenured and least-tenured hiring dates.

WITH status AS (
SELECT
    (LAST_VALUE(hire_date) OVER()) - (FIRST_VALUE(hire_date) OVER()) AS days_diff,
    CASE
        WHEN hire_date = (SELECT MAX(hire_date) FROM uber_employees) 
                                THEN 1 ELSE 0 END AS least_tenured,
    CASE
        WHEN hire_date = (SELECT MIN(hire_date) FROM uber_employees) 
                                THEN 1 ELSE 0 END AS longest_tenured
FROM uber_employees
WHERE termination_date IS NULL
) 

SELECT  
    SUM(least_tenured) AS shortest_tenured_count,
    SUM(longest_tenured) AS longest_tenured_count,
    days_diff
FROM status
GROUP BY days_diff
