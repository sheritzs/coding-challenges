--Output share of US users that are active. Active users are the ones with an "open" status in the table.

with active_users_open_status as (
    select 
        distinct user_id, 
        status
    from fb_active_users
    where status = 'open'
)

select 
round(
(select 
    count(distinct user_id) 
from active_users_open_status) * 1.0  / (
select
    count(distinct user_id) 
from fb_active_users), 1)
