# Write your MySQL query statement below
with cte as
(
    select `minute`, order_count, ceil(`minute`/6) as interval_no
    from orders
),
cte2 as
(
    select interval_no, sum(order_count) as total_orders
    from cte
    group by 1
    order by 1
)
select * from cte2