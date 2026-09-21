# Write your MySQL query statement below

with cte as
(
    select row_number() over(order by x) as rnm, x from point
),
cte2 as
(
    select min(abs(a.x - b.x)) as shortest  from cte a, cte b where a.rnm<> b.rnm
)
select * from cte2;