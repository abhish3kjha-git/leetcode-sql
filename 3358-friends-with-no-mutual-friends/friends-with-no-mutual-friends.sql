# Write your MySQL query statement below
WITH AllFriendships AS (
    -- Friendships are bidirectional; create a full list of both directions
    SELECT user_id1 AS u1, user_id2 AS u2 FROM Friends
    UNION ALL
    SELECT user_id2 AS u1, user_id1 AS u2 FROM Friends
)
SELECT f.user_id1, f.user_id2
FROM Friends f
WHERE NOT EXISTS (
    -- Check if there exists any user m who is friends with both user_id1 and user_id2
    SELECT 1
    FROM AllFriendships af1
    JOIN AllFriendships af2
      ON af1.u2 = af2.u2
    WHERE af1.u1 = f.user_id1
      AND af2.u1 = f.user_id2
)
ORDER BY f.user_id1 ASC, f.user_id2 ASC;