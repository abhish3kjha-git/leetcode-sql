# Write your MySQL query statement below

with cte as
(
    select name as warehouse_name, units*(width*`length`*height) as v 
    from products a join warehouse b on a.product_id = b.product_id
)
select warehouse_name, sum(v) as volume from cte group by 1;