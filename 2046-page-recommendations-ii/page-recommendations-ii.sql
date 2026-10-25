SELECT f.user1_id as user_id,
l.page_id,
COUNT(DISTINCT user2_id) as friends_likes
FROM (
    SELECT user1_id, user2_id FROM Friendship 
    UNION ALL
    SELECT user2_id, user1_id FROM Friendship
     ) f
JOIN Likes l
ON f.user2_id = l.user_id
LEFT JOIN Likes l2
ON f.user1_id = l2.user_id
AND l.page_id = l2.page_id
WHERE l2.page_id is Null
GROUP BY 1,2
ORDER BY 1,3 desc