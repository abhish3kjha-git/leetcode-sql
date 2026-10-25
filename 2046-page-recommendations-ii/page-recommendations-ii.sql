with cte as
(
    SELECT user1_id, user2_id FROM Friendship 
    UNION ALL
    SELECT user2_id, user1_id FROM Friendship
),
cte2 as
(
    select f.user1_id as user_id, l.page_id as pg1, l2.page_id as pg2, f.user2_id
    from cte f join likes l on f.user2_id = l.user_id
    left join likes l2 on f.user1_id = l2.user_id and l.page_id = l2.page_id
    where l2.page_id is null
)
select user_id, pg1 as page_id, count(distinct user2_id) as friends_likes from cte2
group by 1, 2
order by 1, 3


-- SELECT f.user1_id as user_id,
-- l.page_id,
-- COUNT(DISTINCT user2_id) as friends_likes
-- FROM (
--     SELECT user1_id, user2_id FROM Friendship 
--     UNION ALL
--     SELECT user2_id, user1_id FROM Friendship
--      ) f
-- JOIN Likes l
-- ON f.user2_id = l.user_id
-- LEFT JOIN Likes l2
-- ON f.user1_id = l2.user_id
-- AND l.page_id = l2.page_id
-- WHERE l2.page_id is Null
-- GROUP BY 1,2
-- ORDER BY 1,3 desc