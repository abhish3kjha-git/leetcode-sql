# Write your MySQL query statement below
with cte as
(
    select customer_id, product_id, 
    rank() over(partition by customer_id order by count(product_id) desc) as rnk
    from orders
    group by customer_id,product_id
)
select customer_id, a.product_id, product_name from cte a join products b on a.product_id = b.product_id
where rnk =1;