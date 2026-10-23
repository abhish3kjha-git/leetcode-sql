# Write your MySQL query statement below
with cte as
(
    select item_category as category,
    coalesce(sum(case when Dayname(order_date) = 'Monday' then quantity else 0 end), 0) as MONDAY,
    coalesce(sum(case when Dayname(order_date) = 'Tuesday' then quantity else 0 end),0) as TUESDAY,
    coalesce(sum(case when Dayname(order_date) = 'Wednesday' then quantity else 0 end),0) as WEDNESDAY,
    coalesce(sum(case when Dayname(order_date) = 'Thursday' then quantity else 0 end),0) as THURSDAY,
    coalesce(sum(case when Dayname(order_date) = 'Friday' then quantity else 0 end),0) as FRIDAY,
    coalesce(sum(case when Dayname(order_date) = 'Saturday' then quantity else 0 end),0) as SATURDAY,
    coalesce(sum(case when Dayname(order_date) = 'Sunday' then quantity else 0 end),0) as SUNDAY
    from orders a right join items b on a.item_id = b.item_id
    group by 1
)
select * from cte
order by category