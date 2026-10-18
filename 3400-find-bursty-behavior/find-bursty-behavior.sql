# Write your MySQL query statement below
WITH cte AS (   
    SELECT
        p1.user_id,
        COUNT(*) AS cnt
    FROM Posts p1
    JOIN Posts p2
        ON p1.user_id = p2.user_id
        AND p2.post_date BETWEEN 
            p1.post_date AND 
            DATE_ADD(p1.post_date, INTERVAL 6 DAY)
    GROUP BY p1.user_id, p1.post_id
),

average AS (
    SELECT
        user_id,
        COUNT(*) / 4 AS avg_weekly
    FROM Posts
    WHERE post_date BETWEEN '2024-02-01' AND '2024-02-28'
    GROUP BY 1
)

SELECT
    c.user_id,
    MAX(c.cnt) AS max_7day_posts,
    a.avg_weekly AS avg_weekly_posts
FROM cte c
JOIN average a
    ON c.user_id = a.user_id
GROUP BY 1, 3
HAVING MAX(c.cnt) >= (2 * a.avg_weekly)
ORDER BY 1

