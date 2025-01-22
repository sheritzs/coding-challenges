-- Find the total number of downloads for paying and non-paying 
-- users by date. Include only records where non-paying customers
-- have more downloads than paying customers. The output should
-- be sorted by earliest date first and contain 3 columns date,
-- non-paying downloads, paying downloads. Hint: In Oracle you
-- should use "date" when referring to date column (reserved 
-- keyword).


with user_details as (
    select 
        m1.user_id, 
        m2.paying_customer
    from ms_user_dimension m1 join ms_acc_dimension m2
    on m1.acc_id = m2.acc_id
),

user_summary as (
    select
        m.date,
        u.paying_customer,
        sum(m.downloads) as total_downloads
    from user_details u join ms_download_facts m 
    on u.user_id = m.user_id
    group by m.date, u.paying_customer
),


paying_status_summary as (
select 
    date,
    case when paying_customer = 'no' then total_downloads else 0 end as non_paying,
    case when paying_customer = 'yes' then total_downloads else 0 end as paying
from user_summary
    
)

select 
    date,
    sum(non_paying) as non_paying,
    sum(paying) as paying
from paying_status_summary
group by date
having sum(non_paying) > sum(paying)
order by date



