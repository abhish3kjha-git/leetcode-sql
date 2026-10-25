# Write your MySQL query statement below
with cte as
(
    select customer_id, year(order_date) as yr, row_number() over(partition by customer_id order by year(order_date)) as rnm, sum(price) as sm
    from orders
    group by 1, 2
),
cte2 as
(
    select customer_id, yr - rnm as yrgrp, case when sm > coalesce(lag(sm) over(partition by customer_id order by yr), 0) then 1 else 0 end as sig
    from cte
), 
cte3 as
(
    select customer_id, yrgrp, count(*) as numyr, sum(sig) as smgrp, count(*) over(partition by customer_id) as grpcnt
    from cte2
    group by 1, 2
)
select customer_id from cte3 where grpcnt = 1 and numyr = smgrp