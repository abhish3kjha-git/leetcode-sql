# Write your MySQL query statement below
with cte as
(
    select a.user_id from purchases a join purchases b on a.user_id = b.user_id and a.purchase_id <> b.purchase_id and
    a.purchase_date<=b.purchase_date
    where datediff(b.purchase_date, a.purchase_date) between 0 and 7
)
select distinct user_id from cte
order by 1