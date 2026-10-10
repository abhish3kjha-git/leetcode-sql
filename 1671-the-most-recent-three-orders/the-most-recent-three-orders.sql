# Write your MySQL query statement below
with cte as
(
    select order_id, a.customer_id, name, cost, order_date,
    rank() over(partition by a.customer_id order by order_date desc) as rnk
    from orders a join customers b on a.customer_id = b.customer_id
)
select name as customer_name, customer_id, order_id, order_date
from cte 
where rnk<=3
order by customer_name, customer_id, order_date desc