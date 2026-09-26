# Write your MySQL query statement below

with cte as
(
    select lower(trim(product_name)) as product_name, date_format(sale_date, '%Y-%m') as sale_date
    from sales
)
select product_name, sale_date, count(*) as total from cte
group by 1,2
order by product_name ,sale_date