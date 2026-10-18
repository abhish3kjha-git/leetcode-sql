# Write your MySQL query statement below
with cte as
(
    select order_date, 
    case when order_date = customer_pref_delivery_date then 'immediate'
    else 'scheduled' end as type
    from delivery
),
cte2 as
(
    select order_date,
    round(sum(case when type = 'immediate' then 1 else 0 end)*100/ count(*), 2) as immediate_percentage
    from cte
    group by 1 
)
select * from cte2
order by order_date