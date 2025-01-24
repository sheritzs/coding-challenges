-- Write a query that returns the company (customer id column) with highest number of users that use desktop only.

WITH single_event_users AS (
    SELECT
        user_id,
        COUNT(DISTINCT client_id) AS num_unique_events
    FROM fact_events
    GROUP BY user_id
    HAVING COUNT(DISTINCT client_id) = 1
),

desktop_users AS (
    SELECT 
        user_id
    FROM fact_events
    WHERE client_id = 'desktop'
),

counts AS (
    SELECT
        customer_id,
        COUNT(DISTINCT user_id) AS num_users
    FROM fact_events
    WHERE user_id IN (SELECT user_id FROM single_event_users)
        AND user_id IN (SELECT user_id FROM desktop_users)
    GROUP BY customer_id
)
    
SELECT 
    customer_id
FROM counts
WHERE num_users = (SELECT MAX(num_users) FROM counts)

