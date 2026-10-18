# Write your MySQL query statement below
with cte as
(
    select concat(a.topping_name, ',', b.topping_name, ',', c.topping_name) as pizza, 
    a.cost + b.cost + c.cost as total_cost
    from toppings a, toppings b, toppings c
    where a.topping_name< b.topping_name and b.topping_name < c.topping_name
)
select * from cte
order by total_cost desc, pizza