-- You are analyzing a social network dataset at Google. Your task is to 
-- find mutual friends between two users, Karl and Hans. There is only one 
-- user named Karl and one named Hans in the dataset.

-- The output should contain 'user_id' and 'user_name' columns.

with user_friends as (
    SELECT
        u.user_id,
        u.user_name,
        f.friend_id
    FROM friends f JOIN users u 
        USING(user_id)
)

SELECT 
    DISTINCT user_id,
    user_name
FROM user_friends
WHERE user_id IN (SELECT friend_id FROM user_friends WHERE user_name = 'Karl')
    AND user_id IN (SELECT friend_id FROM user_friends WHERE user_name = 'Hans')
