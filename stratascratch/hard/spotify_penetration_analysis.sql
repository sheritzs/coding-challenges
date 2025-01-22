-- Market penetration is an important metric for understanding Spotify's performance and growth potential in different regions.
-- You are part of the analytics team at Spotify and are tasked with calculating the active user penetration rate in specific countries.

-- For this task, 'active_users' are defined based on the  following criterias:

-- last_active_date: The user must have interacted with Spotify within the last 30 days.
-- •    sessions: The user must have engaged with Spotify for at least 5 sessions.
-- •    listening_hours: The user must have spent at least 10 hours listening on Spotify.

-- Based on the condition above, calculate the active 'user_penetration_rate' by using the following formula.

-- •    Active User Penetration Rate = (Number of Active Spotify Users in the Country / Total users in the Country)

-- Total Population of the country is based on both active and non-active users.
-- ​
-- The output should contain 'country' and 'active_user_penetration_rate' rounded to 2 decimals.

-- Let's assume the current_day is 2024-01-31.

with country_active_user_summary as (
select 
    country,
    user_id, 
    sum(listening_hours) as total_listening_hours,
    sum(sessions) as total_sessions
from penetration_analysis 
where last_active_date >= (to_date('2024-01-31', 'YYYY-MM-DD') - 30)
group by country, user_id
having sum(sessions) >= 5 and sum(listening_hours) >= 10 
),

total_active_users as (
    select 
        country,
        count(*) as total_active_users 
    from country_active_user_summary
    group by country
    
),

total_country_users as (
    select 
        country,
        count(*) as total_users
    from penetration_analysis
    group by country
)

select 
    t1.country,
    round(t1.total_active_users *1.0 / t2.total_users, 2)
from total_active_users t1 join total_country_users t2
    on t1.country = t2.country
