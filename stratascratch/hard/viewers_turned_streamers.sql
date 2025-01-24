-- From users who had their first session as a viewer, 
-- how many streamer sessions have they had? Return the user 
-- id and number of sessions in descending order. In case 
-- there are users with the same number of sessions, order 
-- them by ascending user id.

WITH session_order_all AS (
    SELECT 
        *,
        RANK() OVER (PARTITION BY user_id ORDER BY session_start) AS session_order
    FROM twitch_sessions
)

SELECT 
    user_id,
    COUNT(DISTINCT session_id) AS n_sessions
FROM twitch_sessions
WHERE user_id IN (
                    SELECT user_id
                    FROM session_order_all
                    WHERE session_order = 1 AND session_type = 'viewer'
                    ) 
        AND session_type = 'streamer'
GROUP BY user_id
ORDER BY n_sessions DESC, user_id ASC
