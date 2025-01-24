-- Considering a dataset that tracks user interactions with 
-- different clients, identify which clients have users who 
-- are exclusively loyal to them (i.e., they don't interact 
-- with any other clients).

-- For each of these clients, calculate the number of such 
-- exclusive users. The output should include the client_id 
-- and the corresponding count of exclusive users.

WITH solo_client_users AS (
    SELECT 
        user_id,
        COUNT(DISTINCT client_id) AS num_clients
    FROM fact_events
    GROUP BY user_id
    HAVING COUNT(DISTINCT client_id) = 1
)

SELECT 
    f.client_id,
    COUNT(DISTINCT s.user_id)
FROM solo_client_users s JOIN fact_events f
USING(user_id)
GROUP BY f.client_id
