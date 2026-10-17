# Write your MySQL query statement below
with cte as
(
    select user_id,spend, transaction_date, dense_rank() over(partition by user_id order by transaction_date, spend) as drnk,
    max(spend) over(partition by user_id order by transaction_date ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING) as mx_sp
    from transactions
)
select user_id, spend as third_transaction_spend, transaction_date as third_transaction_date from cte where spend>mx_sp and drnk = 3