-- Write a query that returns every employee that has ever worked 
-- for the company. For each employee, calculate the greatest number 
-- of employees that worked for the company during their tenure and 
-- the first date that number was reached. The termination date of an 
-- employee should not be counted as a working day.

-- Your output should have the employee ID, greatest number 
-- of employees that worked for the company during the employee's 
-- tenure, and first date that number was reached.


WITH days_since_last_activity AS 
(
    SELECT 
        hire_date,
        hire_date - LAG(hire_date) OVER(ORDER BY hire_date) AS days_since_last_hire,
        termination_date,
        termination_date - LAG(termination_date) OVER(ORDER BY termination_date) AS days_since_last_term
    FROM uber_employees
)

SELECT 
    MAX(days_since_last_hire),
    MAX(days_since_last_term)
FROM days_since_last_activity;
