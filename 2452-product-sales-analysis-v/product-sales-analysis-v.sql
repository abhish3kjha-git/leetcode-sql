# Write your MySQL query statement below

with cte as
(
    select user_id, quantity*price as spend from sales a join product b on a.product_id = b.product_id

)
select user_id , sum(spend) as spending from cte group by 1
order by spending desc, user_id;