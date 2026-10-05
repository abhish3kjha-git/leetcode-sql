WITH cat_stats AS (
    -- Group by customer and category first
    SELECT 
        t.customer_id,
        p.category,
        COUNT(*) AS cat_tx_cnt,
        MAX(t.transaction_date) AS latest_date
    FROM transactions t
    JOIN products p ON t.product_id = p.product_id
    GROUP BY t.customer_id, p.category
),
ranked_cat AS (
    -- Rank categories to get the top category per customer
    SELECT 
        customer_id,
        category AS top_category,
        ROW_NUMBER() OVER (
            PARTITION BY customer_id 
            ORDER BY cat_tx_cnt DESC, latest_date DESC
        ) AS rn
    FROM cat_stats
),
cust_stats AS (
    -- Calculate customer-level summary stats
    SELECT 
        t.customer_id,
        ROUND(SUM(t.amount), 2) AS total_amount,
        COUNT(t.transaction_id) AS transaction_count,
        COUNT(DISTINCT p.category) AS unique_categories,
        ROUND(AVG(t.amount), 2) AS avg_transaction_amount,
        ROUND(COUNT(t.transaction_id) * 10 + SUM(t.amount) / 100, 2) AS loyalty_score
    FROM transactions t
    JOIN products p ON t.product_id = p.product_id
    GROUP BY t.customer_id
)
SELECT 
    c.customer_id,
    c.total_amount,
    c.transaction_count,
    c.unique_categories,
    c.avg_transaction_amount,
    r.top_category,
    c.loyalty_score
FROM cust_stats c
JOIN ranked_cat r 
  ON c.customer_id = r.customer_id 
 AND r.rn = 1
ORDER BY c.loyalty_score DESC, c.customer_id ASC;