-- Calculate the share of new and existing users for each month 
-- in the table. Output the month, share of new users, and share 
-- of existing users as a ratio.

-- New users are defined as users who started using services in 
-- the current month (there is no usage history in previous months). 
-- Existing users are users who used services in current month, but 
-- they also used services in any previous month.

-- Assume that the dates are all from the year 2020.
-- HINT: Users are contained in user_id column

WITH date_details AS (
    SELECT 
        DISTINCT user_id,
        EXTRACT (MONTH FROM FIRST_VALUE(time_id) OVER(PARTITION BY user_id ORDER BY time_id)) AS first_active_month,
        EXTRACT(MONTH FROM time_id) AS current_month
    FROM fact_events
),

user_status_counts AS (

    SELECT 
        current_month AS month,
        SUM(CASE 
                WHEN first_active_month = current_month THEN 1 ELSE 0 
                END) AS new_users,
        SUM(CASE 
                WHEN first_active_month != current_month THEN 1 ELSE 0 
                END) AS existing_users
                
    FROM date_details
    GROUP BY current_month
)

SELECT 
    month,
    new_users * 1.0 / (new_users + existing_users) AS share_new_users,
    existing_users * 1.0 / (new_users + existing_users) AS share_existing_users
FROM user_status_counts
ORDER BY month
