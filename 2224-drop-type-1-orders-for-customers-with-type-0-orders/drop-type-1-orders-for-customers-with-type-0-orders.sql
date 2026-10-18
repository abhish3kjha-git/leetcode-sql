# Write your MySQL query statement below
with cte as
(
    select * from orders
    where order_type = 0
),
cte2 as
(
    select * from orders
    where customer_id not in (select customer_id from cte)
)
select * from cte
union all
select * from cte2