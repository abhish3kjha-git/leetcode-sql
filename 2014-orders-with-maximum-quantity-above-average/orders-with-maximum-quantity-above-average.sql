# Write your MySQL query statement below
with cte as
(
    select order_id, max(quantity) as mx, avg(quantity) as av
    from OrdersDetails
    group by 1
)
select order_id from cte where mx > (select max(av) from cte)