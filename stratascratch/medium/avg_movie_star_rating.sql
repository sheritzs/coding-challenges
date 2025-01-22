 -- Find the average rating of each movie star along with their names and birthdays. 
 -- Sort the result in the ascending order based on the birthday. Use the names as 
 -- keys when joining the tables.

 with avg_ratings as (
    select 
        name,
        avg(rating) as avg_rating
    from nominee_filmography
    group by name
)

select 
    n.birthday,
    a.name,
    a.avg_rating
from avg_ratings a join nominee_information n
    on a.name = n.name
order by n.birthday
