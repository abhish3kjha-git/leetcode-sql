# Write your MySQL query statement below
with cte as
(
    select customer_id,
    count(case when product_name = 'A' then 1 end) as ac,
    count(case when product_name = 'B' then 1 end) as bc,
    count(case when product_name = 'C' then 1 end) as cc
    from orders
    group by 1
)
select a.customer_id, customer_name from cte a join customers b
on a.customer_id = b.customer_id
where ac >0 and bc> 0 and cc = 0