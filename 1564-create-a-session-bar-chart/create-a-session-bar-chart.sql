WITH cte AS (
    SELECT 
        CASE 
            WHEN duration/60 < 5 THEN '[0-5>'
            WHEN duration/60 < 10 THEN '[5-10>'
            WHEN duration/60 < 15 THEN '[10-15>'
            ELSE '15 or more' 
        END AS `bin`,
        COUNT(session_id) AS total
    FROM sessions
    GROUP BY 1

    UNION ALL SELECT '[0-5>', 0
    UNION ALL SELECT '[5-10>', 0
    UNION ALL SELECT '[10-15>', 0
    UNION ALL SELECT '15 or more', 0
)
SELECT `bin`, SUM(total) AS total
FROM cte
GROUP BY `bin`;