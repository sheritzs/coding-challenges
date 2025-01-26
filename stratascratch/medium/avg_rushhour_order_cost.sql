-- The company you work for has asked you to look into the average 
-- order value per hour during rush hours in the San Jose area. Rush 
-- hour is from 15H - 17H inclusive.

-- You have also been told that the column order_total represents the
-- gross order total for each order. Therefore, you'll need to calculate 
-- the net order total.

-- The gross order total is the total of the order before adding the 
-- tip and deducting the discount and refund.

-- Use the column customer_placed_order_datetime for your calculations.


WITH san_jose_hourly_orders AS (
    SELECT 
        EXTRACT(HOUR FROM customer_placed_order_datetime) AS order_hour,
        (order_total + tip_amount - discount_amount - refunded_amount) as order_net
    FROM delivery_details 
    WHERE delivery_region = 'San Jose'
)

SELECT 
    order_hour,
    AVG(order_net) AS avg_earnings
FROM san_jose_hourly_orders
WHERE order_hour BETWEEN 15 AND 17
GROUP BY order_hour

