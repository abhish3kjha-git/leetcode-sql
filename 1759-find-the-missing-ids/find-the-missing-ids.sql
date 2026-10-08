# Write your MySQL query statement below
with recursive number as
(
    select 1 as n

    union all

    select n+1 from number 
    where n<(select max(customer_id) from customers)
)
select n as ids from number where n not in (select customer_id from customers)