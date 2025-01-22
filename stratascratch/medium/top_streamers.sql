-- List the top 3 users who accumulated the most sessions. Include only the user who had more 
-- streaming sessions than viewing. Return the user_id, number of streaming sessions, and number
-- of viewing sessions.


with stats as (
    select
    user_id,
    count(session_id) as session_count,
    sum(case when session_type = 'streamer' then 1 else 0 end) as streaming,
    sum(case when session_type = 'viewer' then 1 else 0 end) as view
from twitch_sessions
group by user_id
),

ranking as (
    select 
        user_id,
        streaming,
        view,
        row_number() over(order by session_count desc) as rank_
    from stats
where streaming > view
)

select 
    user_id,
    streaming, 
    view
from ranking where rank_ <= 3
