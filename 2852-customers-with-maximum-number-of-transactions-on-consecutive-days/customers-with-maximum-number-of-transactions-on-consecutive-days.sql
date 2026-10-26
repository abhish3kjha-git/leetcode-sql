# Write your MySQL query statement below
with cte as
(
    select *, transaction_date - interval row_number() over(partition by customer_id order by transaction_date) day as rnm
    from transactions
),
cte2 as
(
    select customer_id, rank() over(order by count(*) desc) as rnk
    from cte
    group by customer_id, rnm
)
select distinct customer_id from cte2 where rnk = 1
order by 1