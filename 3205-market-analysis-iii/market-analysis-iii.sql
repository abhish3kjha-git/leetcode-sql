# Write your MySQL query statement below
with cte as
(
    select a.seller_id, a.item_id, item_brand, favorite_brand  
    from orders a join items b on a.item_id = b.item_id
    left join users c on b.item_brand = c.favorite_brand and a.seller_id = c.seller_id
),
cte2 as
(
    select seller_id, count(distinct item_id) as num_items
    from cte
    where favorite_brand is null
    group by 1
),
cte3 as
(
    select seller_id, num_items, rank() over(order by num_items desc) as rnk
    from cte2
)
select seller_id, num_items from cte3 where rnk = 1
order by seller_id