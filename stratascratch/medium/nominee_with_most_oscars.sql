 -- Find the nominee who has won the most Oscars.
-- Output the nominee's name alongside the result.

with ranking as (
    select
        nominee,
        count(winner) as n_times_won,
        dense_rank() over(order by count(winner) desc) as win_rank
    from oscar_nominees
    where winner = TRUE
    group by nominee
    order by n_times_won desc
)

select nominee, n_times_won
from ranking
where win_rank = 1
