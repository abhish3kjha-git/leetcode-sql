# Write your MySQL query statement below
with cte as
(
    select user_id, a.product_id, sum(quantity * price) as spent from sales a join product b on a.product_id = b.product_id
    group by 1, 2
),
cte2 as
(
    select user_id, product_id, rank() over(partition by user_id order by spent desc) as rnk
    from cte
)
-- select * from cte
select user_id, product_id from cte2 where rnk = 1