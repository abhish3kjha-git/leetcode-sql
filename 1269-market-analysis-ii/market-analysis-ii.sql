# Write your MySQL query statement below
with cte as
(
    select a.item_id, seller_id, item_brand, favorite_brand,
    row_number() over(partition by seller_id order by order_date) as rnm
    from orders a join items b on a.item_id = b.item_id 
    join users c on a.seller_id = c.user_id
)
select user_id as seller_id, 
case when item_brand is null then 'no'
when item_brand = b.favorite_brand then 'yes' else 'no' end as 2nd_item_fav_brand
from users a left join cte b on a.user_id = b.seller_id and rnm = 2