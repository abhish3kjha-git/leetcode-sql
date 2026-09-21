# Write your MySQL query statement below

with all_prod as
(
    select buyer_id, product_name from sales a join product b on a.product_id = b.product_id
    where product_name in ('S8', 'iPhone')
),
iphone as
(
    select buyer_id from all_prod where product_name = 'iPhone'
)
select distinct buyer_id from all_prod where buyer_id not in (select * from iphone)
