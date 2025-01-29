-- For each service, calculate the percentage of incomplete 
-- orders along with the revenue loss percentage. Your output
--  should include the name of the service, percentage of 
-- incomplete orders, and revenue loss from the incomplete orders.


WITH service_order_summary AS (

SELECT
    service_name,
    SUM(number_of_orders) AS total_orders,
    SUM(monetary_value) AS total_possible_revenue,
    SUM(CASE
            WHEN status_of_order = 'Completed' THEN 1 ELSE 0 END
        ) AS completed_orders,
    SUM(CASE
        WHEN status_of_order  != 'Completed'  THEN number_of_orders ELSE 0 END
    ) AS incomplete_orders,
    SUM(CASE
        WHEN status_of_order  != 'Completed'  THEN monetary_value ELSE 0 END
    ) AS incomplete_order_value
FROM uber_orders
GROUP BY service_name
)


SELECT 
    service_name,
    (incomplete_orders * 1.0 / total_orders *100 ) AS orders_loss_percent,
    (incomplete_order_value * 1.0 / total_possible_revenue * 100 ) AS profit_loss_percent
FROM service_order_summary
