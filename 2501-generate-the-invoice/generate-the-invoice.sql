# Write your MySQL query statement below
with cte as
(
    select a.*, quantity * price as price 
    from purchases a join products b on a.product_id = b.product_id
),
cte2 as
(
    select *, sum(price) over(partition by invoice_id) as sm
    from cte
),
cte3 as
(
    select *, rank() over(order by sm desc, invoice_id) as rnk
    from cte2
)
select product_id, quantity, price from cte3 where rnk = 1