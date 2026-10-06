# Write your MySQL query statement below

with cte as
(
    select followee as follower, count(follower) as num
    from follow
    group by 1
),
cte2 as
(
    select follower, count(followee) as num
    from follow
    group by 1
),
cte3 as
(
    select follower, num from cte
    where follower in (select follower from cte2)
)
select * from cte3 order by follower;