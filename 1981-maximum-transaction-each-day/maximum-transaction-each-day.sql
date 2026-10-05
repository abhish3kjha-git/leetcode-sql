# Write your MySQL query statement below

with cte as
(
    select transaction_id, date_format(`day`, '%Y-%m-%d') as dt, amount
    from transactions
),
cte2 as
(
    select transaction_id, rank() over(partition by dt order by amount desc) as rnk
    from cte
)
select transaction_id from cte2 where rnk = 1
order by 1;