# Write your MySQL query statement below
with cte as
(
    select a.user_id as user1_id, b.user_id as user2_id, count(*) as common_follower
    from relations a join relations b on a.follower_id = b.follower_id and a.user_id < b.user_id
    group by 1, 2
),
cte2 as
(
    select user1_id, user2_id, 
    rank() over(order by common_follower desc) as rnk
    from cte
)
select user1_id, user2_id from cte2
where rnk = 1