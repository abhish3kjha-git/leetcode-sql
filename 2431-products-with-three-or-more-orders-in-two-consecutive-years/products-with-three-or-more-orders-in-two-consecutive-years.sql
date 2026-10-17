# Write your MySQL query statement below
with cte as
(
    select product_id, year(purchase_date) as yr, count(*) as ord
    from orders
    group by 1, 2
    having ord>=3
)
select distinct a.product_id from cte a join cte b on a.product_id = b.product_id and a.yr - b.yr = 1