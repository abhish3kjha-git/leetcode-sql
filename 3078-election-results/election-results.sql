# Write your MySQL query statement below
with cte as
(
    select voter, candidate, round(1/count(*) over(partition by voter),2) as cnt
    from votes
    where candidate is not null
),
cte2 as
(
    select candidate, sum(cnt) as vc
    from cte
    group by 1
),
cte3 as
(
    select candidate, vc, rank() over(order by vc desc) as rnk
    from cte2
)
select candidate from cte3 where rnk = 1
order by 1