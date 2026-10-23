# Write your MySQL query statement below
with cte as
(
    select year(transaction_date) as `year`, product_id, sum(spend) as curr_year_spend
    from user_transactions
    group by 1, 2
),
cte2 as
(
    select *, lag(curr_year_spend) over(partition by product_id order by year) as prev_year_spend
    from cte
)
select *, round((curr_year_spend - prev_year_spend)*100/prev_year_spend,2) as yoy_rate from cte2
order by product_id, year