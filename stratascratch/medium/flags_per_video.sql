 -- For each video, find how many unique users flagged it. A unique user can be identified using 
 -- the combination of their first name and last name. Do not consider rows in which there is no 
 -- flag ID.


with unique_users_flags as (select 
concat(user_firstname, ' ', user_lastname) AS unique_user,
video_id
from user_flags
where flag_id is not null)


select video_id, count(DISTINCT unique_user) as num_unique_users
from unique_users_flags
group by video_id
