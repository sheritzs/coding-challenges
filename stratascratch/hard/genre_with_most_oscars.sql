-- Find the genre of the person with the most number of oscar winnings.
-- If there are more than one person with the same number of oscar
--  wins, return the first one in alphabetic order based on their
--  name. Use the names as keys when joining the tables.

with win_counts as (
    select
        nominee,
        count(*) as num_wins
    from oscar_nominees
    where winner = True
    group by nominee
)

select 
    n.top_genre
from win_counts w join nominee_information n
    on w.nominee = n.name 
where w.num_wins = (select max(num_wins) from win_counts)
order by n.name
limit 1
