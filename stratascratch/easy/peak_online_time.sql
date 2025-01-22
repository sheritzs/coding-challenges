-- You are given a dataset from Amazon that tracks and aggregates user activity on their platform 
-- in certain time periods. For each device type, find the time period with the highest number of active users.

-- The output should contain 'user_count', 'time_period', and 'device_type', where 'time_period' is a concatenation 
-- of 'start_timestamp' and 'end_timestamp', like ; "start_timestamp to end_timestamp".

with time_period_activity as (
select
    concat(start_timestamp, ' to ', end_timestamp) as time_period,
    dense_rank() over(partition by device_type order by user_count desc) as rank_,
    user_count,
    device_type
from user_activity
)

select user_count, time_period, device_type
from time_period_activity
where rank_ = 1
