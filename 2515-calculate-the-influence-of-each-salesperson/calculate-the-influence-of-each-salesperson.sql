# Write your MySQL query statement below
with cte as
(
    select customer_id, sum(price) as total
    from sales
    group by 1
),
cte2 as
(
    select salesperson_id, sum(total) as total
    from customer a join cte b on a.customer_id = b.customer_id
    group by 1
)
select a.salesperson_id, name, coalesce(total, 0) as total from salesperson a left join cte2 b on a.salesperson_id = b.salesperson_id