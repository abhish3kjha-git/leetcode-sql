# Write your MySQL query statement below
with recursive cte as
(
    select product_id, period_start, average_daily_sales
    from sales

    union all

    select product_id, period_start + interval 1 day as period_start, average_daily_sales
    from cte a
    where period_start< (select period_end from sales b where a.product_id = b.product_id)
),
cte2 as
(
    select product_id, CAST(YEAR(period_start) AS CHAR) as report_year, sum(average_daily_sales) as total_amount
    from cte
    group by 1, 2
),
cte3 as
(
    select a.product_id, product_name, report_year, total_amount
    from cte2 a join product b on a.product_id = b.product_id 
)
select * from cte3
order by product_id, report_year