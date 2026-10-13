# Write your MySQL query statement below
with cte as
(
    select id, drink, row_number() over() as rnm,
    case when drink is not null then 1 else 0 end as dgrp
    from coffeeshop
),
cte2 as
(
    select id, drink, sum(dgrp) over(order by rnm) as grp
    from cte
),
cte3 as
(
    select grp, max(drink) as drink
    from cte2
    group by 1
)
select id, a.drink from cte3 a join cte2 b on a.grp = b.grp
