-- After a new user creates an account and starts watching videos, the user ID, video ID, 
-- and date watched are captured in the database. Find the top 3 videos most users have 
-- watched as their first 3 videos. Output the video ID and the number of times it has been 
-- watched as the users' first 3 videos.

-- In the event of a tie, output all the videos in the top 3 that users watched as their first 3 videos.

with first_watched_rank as (
    select 
        user_id, 
        video_id,
        watched_at,
        dense_rank() over(partition by user_id order by watched_at) as user_rank
    from videos_watched
),

top_3_first_watched as (select 
    video_id,
    count(*) AS n_in_first_3
from first_watched_rank
where user_rank <= 3
group by video_id
order by n_in_first_3 desc
)

select video_id, n_in_first_3
top_3_first_watched
where  user_rank <= 3
