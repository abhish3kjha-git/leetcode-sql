# Write your MySQL query statement below
with cte as
(
    select a.product_id, product_name, order_id, order_date,
    rank() over(partition by a.product_id order by order_date desc) as rnk
    from orders a join products b on a.product_id = b.product_id
)
select product_name, product_id,  order_id, order_date from cte
where rnk = 1
order by product_name, product_id, order_id 