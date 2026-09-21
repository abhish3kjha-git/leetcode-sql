# Write your MySQL query statement below
with cte as
(
    select seller_id, sum(price) as total from sales
    group by seller_id
),
rnk as
(
    select seller_id, rank() over(order by total desc) as srank
    from cte
)
select seller_id from rnk where srank =1;