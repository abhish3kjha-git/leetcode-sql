# Write your MySQL query statement below

-- with cte as
-- (
--     select 
--     customer_id,
--     sum(amount) as total_amount,
--     count(transaction_id) as transaction_count,
--     count(distinct category) as unique_categories,
--     avg(amount) as avg_transaction_amount ,
--     round(count(transaction_id)*10 + (sum(amount)/100),2) as loyalty_score 
--     from transactions a join products b on a.product_id = b.product_id
--     group by customer_id
-- ),
-- cte2 as
-- (
--     select customer_id, category as top_category ,
--     rank() over(partition by customer_id order by count(category) desc, transaction_date desc) as rnk
--     from transactions a join products b on a.product_id = b.product_id
--     group by customer_id, category
-- )
-- select a.customer_id, total_amount, transaction_count, unique_categories, 
-- avg_transaction_amount, top_category , loyalty_score 
-- from cte a join cte2 b on a.customer_id = b.customer_id 
-- where rnk =1
-- order by loyalty_score desc, customer_id

# Write your MySQL query statement below
WITH joined AS (
    SELECT 
        t.transaction_id,
        t.customer_id,
        p.product_id,
        t.transaction_date,
        t.amount,
        p.category,
        p.price
    FROM 
        transactions t
    INNER JOIN 
        products p ON t.product_id = p.product_id
),

amount_count AS (
    SELECT 
        customer_id,
        ROUND(SUM(amount), 2) AS total_amount,
        COUNT(transaction_id) AS transaction_count,
        COUNT(DISTINCT category) AS unique_categories,
        ROUND(SUM(amount)/COUNT(transaction_id), 2) AS avg_transaction_amount,
        ROUND((COUNT(transaction_id) * 10) + (SUM(amount) / 100), 2) AS loyalty_score
    FROM 
        joined
    GROUP BY 
        customer_id
),

top_category AS (
    SELECT 
        customer_id,
        category,
        DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC, MAX(transaction_date) DESC) AS rn
    FROM 
        joined
    GROUP BY 
        customer_id, category
)

SELECT 
    ac.customer_id, 
    ac.total_amount, 
    ac.transaction_count, 
    ac.unique_categories, 
    ac.avg_transaction_amount, 
    tc.category AS top_category, 
    ac.loyalty_score
FROM 
    amount_count ac
LEFT JOIN 
    top_category tc ON ac.customer_id = tc.customer_id
WHERE 
    tc.rn = 1
ORDER BY 
    ac.loyalty_score DESC, ac.customer_id ASC;