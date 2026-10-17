# Write your MySQL query statement below
with cte as
(
    select FLOOR((DAY(purchase_date) - 1) / 7) + 1 AS week_of_month,
    purchase_date, 
    sum(amount_spend) as total_amount
    from purchases
    where purchase_date like '2023-11%' 
    and date_format(purchase_date, '%W') = 'Friday'
    group by 1, 2
    order by week_of_month
)
select * from cte