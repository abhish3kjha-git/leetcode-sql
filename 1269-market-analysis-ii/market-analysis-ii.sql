# Write your MySQL query statement below
WITH SecondOrders AS (
    SELECT 
        seller_id, 
        item_id
    FROM (
        SELECT 
            seller_id, 
            item_id,
            ROW_NUMBER() OVER (
                PARTITION BY seller_id 
                ORDER BY order_date ASC
            ) AS rn
        FROM Orders
    ) ranked
    WHERE rn = 2
)
SELECT 
    u.user_id AS seller_id,
    CASE 
        WHEN i.item_brand = u.favorite_brand THEN 'yes' 
        ELSE 'no' 
    END AS 2nd_item_fav_brand
FROM Users u
LEFT JOIN SecondOrders so ON u.user_id = so.seller_id
LEFT JOIN Items i ON so.item_id = i.item_id
ORDER BY u.user_id;