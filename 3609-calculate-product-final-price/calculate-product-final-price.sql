# Write your MySQL query statement below
with cte as
(
    select product_id, price - coalesce(price * discount/100, 0) as final_price, a.category
    from products a left join discounts b on a.category = b.category
)
select * from cte