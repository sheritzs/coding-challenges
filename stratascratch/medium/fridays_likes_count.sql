-- You have access to Facebook's database which includes several tables relevant to 
-- user interactions. For this task, you are particularly interested in tables that 
-- store data about user posts, friendships, and likes. Calculate the total number of 
-- likes from friends for each date that falls on a Friday. Only include likes from 
-- friends in your totals.

-- The output should contain two different columns 'likes' and 'date'.

WITH friday_likes AS (
    SELECT
        l.user_name AS like_author,
        u.user_name AS post_author,
        l.user_name || '_' || u.user_name AS f_combo_id,
        l.post_id,
        l.date_liked   FROM likes l JOIN user_posts u
            USING (post_id)
    WHERE EXTRACT(DOW FROM date_liked) = 5
),

friendship_combos AS (
    SELECT 
        user_name1 || '_' || user_name2 as u1u2,
        user_name2 || '_' || user_name1 as u2u1
    FROM friendships
)

SELECT 
    date_liked,
    COUNT(like_author) AS likes
FROM friday_likes
WHERE f_combo_id IN (SELECT u1u2 FROM friendship_combos)
    OR f_combo_id IN (SELECT u2u1 FROM friendship_combos)
GROUP BY date_liked
