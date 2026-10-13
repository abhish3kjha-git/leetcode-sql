# Write your MySQL query statement below
WITH friends AS ( 
    SELECT
        user1_id AS user_id,
        user2_id AS friend_id
    FROM Friendship

        UNION ALL

    SELECT
        user2_id AS user_id,
        user1_id AS friend_id
    FROM Friendship
)

SELECT
    f1.user_id AS user1_id,
    f2.user_id AS user2_id,
    COUNT(*) AS common_friend
FROM friends f1
JOIN friends f2
    -- Same friend_id means f1 and f2 share that friend
    ON f1.friend_id = f2.friend_id
    -- Avoid counting (1,3) and (3,1) separately
    AND f1.user_id < f2.user_id

-- The two users themselves must also be friends
JOIN Friendship f
    ON f.user1_id = f1.user_id
    AND f.user2_id = f2.user_id 

GROUP BY 1, 2

-- Strong friendship = at least 3 common friends
HAVING COUNT(*) >= 3
