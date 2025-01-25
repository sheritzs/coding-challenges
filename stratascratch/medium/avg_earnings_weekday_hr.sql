-- You have been asked to calculate the average earnings per order 
-- segmented by a combination of weekday (all 7 days) and hour using 
-- the column customer_placed_order_datetime.

-- You have also been told that the column order_total represents the 
-- gross order total for each order. Therefore, you'll need to calculate 
-- the net order total.

-- The gross order total is the total of the order before adding the 
-- tip and deducting the discount and refund.

-- Note: In your output, the day of the week should be represented in 
-- text format (i.e., Monday). Also, round earnings to 2 decimals

WITH order_date_details AS (
SELECT
    consumer_id || '_' || customer_placed_order_datetime AS order_id,
    TO_CHAR(customer_placed_order_datetime, 'Day') AS weekday,
    EXTRACT(HOUR FROM customer_placed_order_datetime) AS hour,
    (order_total + tip_amount - discount_amount - refunded_amount) AS order_total_net
FROM doordash_delivery
)

SELECT 
    weekday,
    hour,
    AVG(order_total_net) AS avg_earnings
FROM order_date_details
GROUP BY weekday, hour
