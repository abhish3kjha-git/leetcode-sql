# Write your MySQL query statement below
with cte as
(
    select activity , count(id) as performed_by
    from friends
    group by 1
),
cte2 as
(
    select name , coalesce(performed_by , 0) as pf from activities a join cte b on a.name = b.activity
)
select name as activity from cte2 where pf <> (select max(pf) from cte2) and pf <> (select min(pf) from cte2)