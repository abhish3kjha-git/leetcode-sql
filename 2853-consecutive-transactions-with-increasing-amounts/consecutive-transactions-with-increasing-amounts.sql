# Write your MySQL query statement below
with cte as
(
    select *, transaction_date - interval row_number() over(partition by customer_id order by transaction_date) day as rnm
    from transactions
),
cte2 as
(
    select *, case when amount> coalesce(lag(amount) over(partition by customer_id, rnm order by transaction_date), 0) then 0 else 1 end as prev_amt
    from cte
),
cte3 as
(
    select customer_id, transaction_date, rnm, amount, prev_amt, sum(prev_amt) over(partition by customer_id, rnm order by transaction_date) as grp
    from cte2
),
cte4 as
(
    select customer_id, min(transaction_date) as consecutive_start, max(transaction_date) as consecutive_end
    from cte3
    -- where prev_amt = 0
    group by customer_id, rnm, grp
    having count(*)>=3
)
select * from cte4
-- where customer_id = 35
order by 1, 2, 3