# Write your MySQL query statement below

with cte as
(
    select pid, sum(amount) as amount from
    (select paid_by as pid, -1*amount as amount from transactions
    union all
    select paid_to as pid, amount from transactions) o
    group by 1
),
cte2 as
(
    select user_id, user_name, credit + coalesce(amount, 0) as credit
    from users a left join cte b on user_id = pid
)
select *,
case when credit>=0 then "No"
else "Yes" end as credit_limit_breached
from cte2