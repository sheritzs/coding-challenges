-- Select the most popular client_id based on a count of the 
-- number of users who have at least 50% of their events from
-- the following list: 'video call received', 'video call sent', 
-- 'voice call received', 'voice call sent'.


WITH event_counts AS (
    SELECT 
        client_id,
        user_id,
        COUNT(event_id) AS num_events,
        SUM(CASE 
                WHEN event_type = 'video call received' THEN 1 ELSE 0
                END) AS video_received_counts, 
        SUM(CASE 
                WHEN event_type = 'video call sent' THEN 1 ELSE 0
                END) AS video_sent_counts, 
        SUM(CASE 
                WHEN event_type = 'voice call sent' THEN 1 ELSE 0
                END) AS voice_sent_counts
    FROM fact_events
    GROUP BY client_id, user_id
),

counts as (
SELECT 
    client_id,
    SUM(CASE
        WHEN (video_received_counts + video_sent_counts + voice_sent_counts) *1.0  / num_events >= 0.5 THEN 1 ELSE 0
    END) as num_users_50p
FROM event_counts
GROUP BY client_id
ORDER BY num_users_50p DESC LIMIT 1
)

SELECT client_id
FROM counts
WHERE num_users_50p = (SELECT MAX(num_users_50p) FROM counts)
