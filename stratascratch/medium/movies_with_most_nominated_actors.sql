-- Find movies that had the most nominated actors/actresses. Be aware of the fact 
-- that some movies have the same name. Use the year column to separate count for such movies.

-- Output the movie name alongside the number of nominees.
-- Order the result in descending order.


with nom_counts as (
select
    concat(movie, year) as unique_id,
    movie, 
    count(*) as n_occurences
from oscar_nominees
group by 1, 2
)

select movie, n_occurences
from nom_counts 
order by n_occurences desc
