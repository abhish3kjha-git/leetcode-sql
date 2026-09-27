# Write your MySQL query statement below

with cte as
(
    select distinct seller_id from orders where sale_date like '2020-%'
)
select seller_name from seller where seller_id not in (select seller_id from cte)
order by seller_name