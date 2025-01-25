-- Find the most profitable location. Write a query that calculates the
-- average signup duration and average transaction amount for each 
-- location, and then compare these two measures together by taking 
-- the ratio of the average transaction amount and average duration 
-- for each location.

-- Your output should include the location, average duration, average 
-- transaction amount, and ratio. Sort your results from highest ratio
--  to lowest.

-- avg signup duraction per location
-- avg transaction amount per location 
-- ratio of avg transaction & duraction 
-- order from highest ratio to lowest (DESC)

WITH avg_duration AS (
    SELECT
        location,
        AVG(signup_stop_date - signup_start_date) AS mean_duration
    from signups
    GROUP BY location
),

avg_transaction_sum AS (
    SELECT 
        s.location,
        AVG(amt) AS mean_revenue
    FROM transactions t LEFT JOIN signups s
        USING(signup_id)
    GROUP BY s.location
)

SELECT 
    a1.location,
    a1.mean_duration,
    a2.mean_revenue,
    a2.mean_revenue * 1.0/a1.mean_duration AS ratio
FROM avg_duration a1 JOIN avg_transaction_sum a2
    USING(location)
ORDER BY ratio DESC
