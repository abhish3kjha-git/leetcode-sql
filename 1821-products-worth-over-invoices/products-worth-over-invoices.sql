# Write your MySQL query statement below

select name, 
coalesce(sum(rest),0) as rest, 
coalesce(sum(paid),0) as paid, 
coalesce(sum(canceled ),0) as canceled, 
coalesce(sum(refunded),0) as refunded
from invoice a right join product b on a.product_id = b.product_id
group by 1
order by 1