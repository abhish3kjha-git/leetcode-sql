# Write your MySQL query statement below
with cte as
(
    select account_id, `day`, 
    case when type = 'Deposit' then amount
    else -1*amount end as amount
    from transactions
)
select account_id, `day`,
sum(amount) over(partition by account_id order by `day`) as balance
from cte
order by 1,2;