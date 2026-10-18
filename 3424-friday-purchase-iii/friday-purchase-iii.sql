WITH RECURSIVE weeks AS (
    SELECT
        1 AS week_of_month
    
        UNION ALL
    
    SELECT
        week_of_month + 1
    FROM weeks
    WHERE week_of_month < 4
),

memberships AS (
    SELECT 'Premium' AS membership

    UNION ALL

    SELECT 'VIP'
),

purchase_data AS (
    SELECT
        CEIL(DAYOFMONTH(p.purchase_date) / 7) AS week_of_month,
        u.membership,
        p.amount_spend
    FROM Purchases p
    JOIN Users u
        ON u.user_id = p.user_id
    WHERE DAYOFWEEK(p.purchase_date) = 6
)

SELECT
    w.week_of_month,
    m.membership,
    COALESCE(SUM(p.amount_spend), 0) AS total_amount
FROM weeks w
CROSS JOIN memberships m
LEFT JOIN purchase_data p
    ON p.week_of_month = w.week_of_month
    AND p.membership = m.membership
GROUP BY 1, 2
ORDER BY 1, 2
