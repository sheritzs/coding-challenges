-- Count the number of movies for which Abigail Breslin was nominated for an Oscar.

SELECT COUNT(*)
FROM oscar_nominees
WHERE nominee = 'Abigail Breslin'
