-- Identify users who started a session and placed an order on the
-- same day. For these users, calculate the total number of orders 
-- and the total order value for that day.

-- Your output should include the user, the session date, the total 
-- number of orders, and the total order value for that day.

with daily_order_summary as (
    select 
        user_id,
        order_date,
        count(order_date) as total_orders,
        sum(order_value) as total_order_value
    from order_summary
    group by user_id, order_date
)

select 
    distinct d.user_id, 
    s.session_date,
    d.total_orders,
    d.total_order_value
from daily_order_summary d join sessions s
on d.user_id = s.user_id and d.order_date = s.session_date
