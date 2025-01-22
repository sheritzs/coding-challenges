-- Find all the users who were active for 3 consecutive days or more.

with user_dates as (
    select
        user_id,
        lag(date, 1) over(partition by user_id order by date) as prev_date,
        date,
        lead(date,1) over(partition by user_id order by date) as next_date
    from sf_events
)

select user_id
from user_dates
where datediff(date, prev_date) = 1
and datediff(next_date, date) = 1
