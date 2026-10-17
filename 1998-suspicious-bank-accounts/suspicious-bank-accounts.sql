# Write your MySQL query statement below
WITH cte AS
(
    SELECT 
        account_id, 
        SUM(CASE WHEN type = 'Creditor' THEN amount ELSE 0 END) AS ti, 
        DATE_FORMAT(`day`, '%Y-%m') AS mth
    FROM transactions
    GROUP BY account_id, mth
),
cte2 AS
(
    SELECT 
        a.account_id, 
        a.mth,
        b.max_income, 
        a.ti
    FROM cte a 
    JOIN accounts b ON a.account_id = b.account_id
    WHERE a.ti > b.max_income
),
cte3 AS
(
    SELECT 
        account_id,
        mth,
        -- Get the next exceeding month for the account
        LEAD(mth) OVER (PARTITION BY account_id ORDER BY mth) AS next_mth
    FROM cte2
)
SELECT DISTINCT account_id
FROM cte3
-- Check if next_mth is exactly 1 month after mth
WHERE PERIOD_DIFF(REPLACE(next_mth, '-', ''), REPLACE(mth, '-', '')) = 1
ORDER BY account_id ASC;