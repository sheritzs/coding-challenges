-- Find the average daily active users for January 2021 for each account.
-- Your output should have account_id and the average daily count for
--  that account.

WITH daily_users AS (
    SELECT
        account_id,
        EXTRACT(DAY FROM date) AS day,
        COUNT(DISTINCT user_id) AS num_daily_users
    FROM sf_events
    WHERE EXTRACT(YEAR FROM date) = 2021 AND EXTRACT(MONTH FROM date) = 1
    GROUP BY account_id, EXTRACT(DAY FROM date)
)

SELECT 
    account_id,
    SUM(num_daily_users) / 30.0 AS average
FROM daily_users
GROUP BY account_id
