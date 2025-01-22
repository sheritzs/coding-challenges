-- Which countries have risen in the rankings based on the 
-- number of comments between Dec 2019 vs Jan 2020? 
-- Hint: Avoid gaps between ranks when ranking countries.

with country_comments as (
    select 
        f2.country,
        to_char(f1.created_at, 'yyyymm') as year_month,
        to_char(f1.created_at, 'Mon yyyy') as month_year,
        sum(f1.number_of_comments) as total_comments
    from fb_comments_count f1 join fb_active_users f2
        on f1.user_id = f2.user_id
    group by f2.country, to_char(f1.created_at, 'yyyymm'), to_char(f1.created_at, 'Mon yyyy')
),

ranking as (
    select 
        *,
        dense_rank() over(partition by year_month order by total_comments desc) as current_month_rank
    from country_comments
    order by year_month
),

rank_changes as (
    select 
        *,
        lag(current_month_rank) over(partition by country order by year_month) as prev_month_rank
    from ranking

)

select country
from rank_changes
where (month_year = 'Jan 2020' and current_month_rank < prev_month_rank)
    or (month_year = 'Jan 2020' and prev_month_rank is null)
