# Write your MySQL query statement below
with recursive cte as
(
    select num, 1 as cnt
    from numbers

    union all
    
    select num, cnt + 1
    from cte a
    where cnt<(select frequency from numbers b where a.num = b.num)
),
cte2 as
(
    select *, row_number() over(order by num) as rnm, count(*) over()as total
    from cte
)
-- select * from cte2
select case when max(total)%2=0 then round(sum(num)/2,2) else num end as median
from cte2
where rnm between total/2 and total/2 +1