WITH user_daily_platform AS (
    SELECT 
        user_id, 
        spend_date,
        CASE 
            WHEN COUNT(DISTINCT platform) = 2 THEN 'both'
            ELSE MAX(platform)
        END AS platform,
        SUM(amount) AS amt
    FROM spending
    GROUP BY user_id, spend_date
),
summary AS (
    SELECT 
        spend_date, 
        platform, 
        SUM(amt) AS total_amount, 
        COUNT(DISTINCT user_id) AS total_users
    FROM user_daily_platform
    GROUP BY spend_date, platform
),
all_combinations AS (
    SELECT DISTINCT s.spend_date, p.platform
    FROM spending s
    CROSS JOIN (
        SELECT 'desktop' AS platform
        UNION ALL
        SELECT 'mobile'
        UNION ALL
        SELECT 'both'
    ) p
)
SELECT 
    a.spend_date, 
    a.platform,
    COALESCE(s.total_amount, 0) AS total_amount,
    COALESCE(s.total_users, 0) AS total_users
FROM all_combinations a
LEFT JOIN summary s 
    ON a.spend_date = s.spend_date 
   AND a.platform = s.platform
ORDER BY a.spend_date, a.platform DESC;