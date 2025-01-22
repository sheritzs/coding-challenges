-- You have a table of in-app purchases by user. 
-- Users that make their first in-app purchase are placed 
-- in a marketing campaign where they see call-to-actions 
-- for more in-app purchases. Find the number of users that 
-- made additional in-app purchases due to the success of the 
-- marketing campaign.

-- The marketing campaign doesn't start until one day after 
-- the initial in-app purchase so users that only made one or 
-- multiple purchases on the first day do not count, nor do we 
-- count users that over time purchase only the products they 
-- purchased on the first day.


with purchases_tracker as (
    select 
        user_id,
        created_at, 
        dense_rank() over(partition by user_id order by created_at) as purchase_num,
        concat(user_id, '_', product_id) as user_product_id
    from marketing_campaign
)

select 
   count (distinct user_id)
from purchases_tracker 
where purchase_num > 1 
    and user_product_id not in 
                                (
                            select 
                                user_product_id
                            from purchases_tracker
                            where purchase_num = 1 
                        )
