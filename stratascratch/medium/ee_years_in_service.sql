-- Find employees who have worked for Uber for more than 
-- 2 years (730 days) and check to see if they're still part 
-- of the company. Output 'Yes' if they are and 'No' if they 
-- are not. Use May 1, 2021 as your date of reference when 
-- calculating whether they have worked for more than 2 years 
-- since their hire date.
-- Output the first name, last name, whether or not the employee
--  is still working for Uber, and the number of years at the company.


WITH status AS (
SELECT
    first_name,
    last_name,
    hire_date,
    CASE 
        WHEN termination_date IS NULL THEN TO_DATE('2021-05-01', 'YYYY-MM-DD') ELSE termination_date END AS key_date,
    CASE 
        WHEN termination_date IS NULL THEN 'Yes' ELSE 'No' END AS still_employed
FROM uber_employees 
)

SELECT
    first_name,
    last_name,
    (key_date - hire_date) / 365.0 AS years_spent,
    still_employed
FROM status
WHERE (key_date - hire_date) / 365.0 > 2 

