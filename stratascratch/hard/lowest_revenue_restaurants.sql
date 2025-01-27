-- Write a query that returns a list of the bottom 2% revenue
--  generating restaurants. Return a list of restaurant IDs 
-- and their total revenue from when customers placed orders 
-- in May 2020.

-- You can calculate the total revenue by summing the order_total 
-- column. And you should calculate the bottom 2% by partitioning 
-- the total revenue into evenly distributed buckets.

WITH order_totals AS (
    SELECT 
        restaurant_id,
        SUM(order_total) AS total_order,
        NTILE(100) OVER (ORDER BY SUM(order_total)) AS percent_rank
    FROM doordash_delivery
    GROUP BY restaurant_id
)

SELECT 
    restaurant_id,
    total_order
FROM order_totals
WHERE percent_rank <= 2
