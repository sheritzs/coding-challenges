-- As a data scientist at Amazon Prime Video, you are tasked with enhancing the 
-- in-flight entertainment experience for Amazon’s airline partners. 
-- Your challenge is to develop a feature that suggests individual movies from 
-- Amazon's content database that fit within a given flight's duration. For flight 101, 
-- find movies whose runtime is less than or equal to the flight's duration.

-- The output should list suggested movies for the flight, including 
-- 'flight_id', 'movie_id', and 'movie_duration'."

select
    101 as flight_id,
    movie_id,
    duration as movie_duration
from entertainment_catalog
where duration <= (select flight_duration from flight_schedule where flight_id = 101)
