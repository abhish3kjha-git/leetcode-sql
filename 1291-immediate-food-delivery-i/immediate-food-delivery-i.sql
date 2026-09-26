# Write your MySQL query statement below
with cte as
(
    select count(distinct delivery_id) as imd from delivery where order_date = customer_pref_delivery_date 
)
select round(imd*100/(select count(distinct delivery_id) from delivery), 2) as immediate_percentage
from cte;