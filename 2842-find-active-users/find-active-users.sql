# Write your MySQL query statement below
with cte as
(
    select *,row_number() over(order by user_id) as rnm from users
),
cte2 as
(
    select distinct a.user_id from cte a join cte b on a.user_id = b.user_id and a.rnm<>b.rnm and datediff(a.created_at, b.created_at) between 0 and 7
)
select * from cte2;