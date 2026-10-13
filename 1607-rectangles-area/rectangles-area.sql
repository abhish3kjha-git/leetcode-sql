# Write your MySQL query statement below
with cte as
(
    select a.id as P1 , b.id as P2, abs(a.x_value - b.x_value) * abs(a.y_value - b.y_value ) as `AREA`
    from points a join points b on a.id<b.id
)
select * from cte where `area` <>0
order by `AREA` desc, P1, P2