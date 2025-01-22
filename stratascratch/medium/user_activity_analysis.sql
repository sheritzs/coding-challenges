-- Identify users who have logged at least one activity within 30 days of their registration date.

-- Your output should include the user’s ID, registration date, and a count of the number of 
-- activities logged within that 30-day period.

-- Do not include users who did not perform any activity within this 30-day period.

with registration_activity_window as (
    select
        user_id,
        signup_date,
        signup_date  + 30 as reg_act_wind_lastdate
    from user_profiles
),

total_daily_user_activities as (
    select 
        user_id,
        activity_date,
        count(activity_type) as activity_count
    from user_activities 
    group by user_id, activity_date
)

select 
    r.user_id,
    r.signup_date,
    sum(t.activity_count)
from registration_activity_window r 
    join total_daily_user_activities t 
    on r.user_id = t.user_id and t.activity_date <= r.reg_act_wind_lastdate
group by r.user_id, r.signup_date
