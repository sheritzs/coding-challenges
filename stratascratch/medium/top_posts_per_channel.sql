-- Identify the top 3 posts with the highest like counts for each channel. 
-- Assign a rank to each post based on its like count, allowing for gaps in 
-- ranking when posts have the same number of likes. For example, if two posts 
-- tie for 1st place, the next post should be ranked 3rd, not 2nd. Exclude any 
-- posts with zero likes.

-- The output should display the channel name, post ID, post creation date, and 
-- the like count for each post.


WITH rankings as (
    SELECT 
        c.channel_name,
        p.post_id, 
        p.created_at,
        p.likes,
        RANK() OVER (PARTITION BY channel_id ORDER BY likes DESC) as likes_rank
    FROM posts p JOIN channels c 
        USING(channel_id)
    WHERE p.likes > 0
)

SELECT 
    channel_name, 
    post_id, 
    created_at,
    likes
FROM rankings
WHERE likes_rank <= 3 
