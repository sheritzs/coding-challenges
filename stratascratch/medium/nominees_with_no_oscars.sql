-- Find the nominees who have been nominated the most but have never won an Oscar. 
-- Output the number of unsuccessful nominations alongside the nominee's name.
--  Order records based on the number of nominations in descending order.

select
    nominee,
    count(*) as noms
from oscar_nominees 
where nominee not in (select nominee from oscar_nominees where winner = TRUE)
group by nominee 
order by noms desc
