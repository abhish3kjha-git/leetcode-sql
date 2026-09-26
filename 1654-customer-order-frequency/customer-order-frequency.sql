# Write your MySQL query statement below

with cte as
(
    select customer_id, 
    year(order_date), month(order_date),sum(quantity * price) as sm
    from orders a join product b on a.product_id = b.product_id 
    where (order_date like '2020-06%' or order_date like '2020-07%')
    group by customer_id, year(order_date), month(order_date)

),
cte2 as
(
    select customer_id from cte
    where sm>=100 
    group by 1
    having count(customer_id)>1
)
select a.customer_id, name from cte2 a join customers b on a.customer_id = b.customer_id
