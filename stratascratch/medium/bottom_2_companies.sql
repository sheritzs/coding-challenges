-- Write a query that returns a list of the bottom 2 companies 
-- by mobile usage. Company is defined in the customer_id column. 
-- Mobile usage is defined as the number of events registered on 
-- a client_id == 'mobile'. Order the result by the number of events 
-- ascending.

-- In the case where there are multiple companies tied for the
-- bottom ranks (rank 1 or 2), return all the companies. Output 
-- the customer_id and number of events.

WITH mobile_usage_ranking AS (
    SELECT
        customer_id,
        COUNT(event_id) AS events,
        DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT event_id) ) AS mobile_use_rank
    FROM fact_events
    WHERE client_id = 'mobile'
    GROUP BY customer_id
)

SELECT
    customer_id,
    events
FROM mobile_usage_ranking
WHERE mobile_use_rank <= 2
ORDER BY events
