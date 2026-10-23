WITH RECURSIVE visit_txns AS (
    -- Step 1: Count transactions per visit directly in one aggregation pass
    SELECT 
        COUNT(b.transaction_date) AS transactions_count
    FROM Visits a
    LEFT JOIN Transactions b 
        ON a.user_id = b.user_id 
       AND a.visit_date = b.transaction_date
    GROUP BY a.user_id, a.visit_date
),
visit_summary AS (
    -- Step 2: Calculate visit counts and track max transactions for the sequence generator
    SELECT 
        transactions_count, 
        COUNT(*) AS visits_count
    FROM visit_txns
    GROUP BY transactions_count
),
numbers AS (
    -- Step 3: Generate 0 to MAX(transactions_count)
    SELECT 0 AS transactions_count
    UNION ALL
    SELECT transactions_count + 1 
    FROM numbers
    WHERE transactions_count < (SELECT COALESCE(MAX(transactions_count), 0) FROM visit_summary)
)
SELECT 
    n.transactions_count,
    COALESCE(s.visits_count, 0) AS visits_count
FROM numbers n
LEFT JOIN visit_summary s 
    ON n.transactions_count = s.transactions_count
ORDER BY n.transactions_count;