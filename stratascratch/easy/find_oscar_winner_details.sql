-- Find details of oscar winners between 2001 and 2009

select * from oscar_nominees
where year between 2001 and 2009 
and winner = TRUE
