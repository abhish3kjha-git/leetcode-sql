# Write your MySQL query statement below
with cte as
(
    select a.x, a.y
    from coordinates a join coordinates b on a.x = b.y and a.y = b.x
    where a.x<=b.x
    group by 1, 2
    having a.x <> a.y or count(*)>=2
    order by 1, 2
)
select * from cte