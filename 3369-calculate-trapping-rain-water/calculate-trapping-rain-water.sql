WITH cte AS (
    SELECT 
        id, 
        height, 
        MAX(height) OVER (
            ORDER BY id 
            range BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
        ) AS max_before,
        MAX(height) OVER (
            ORDER BY id 
            range BETWEEN 1 FOLLOWING AND UNBOUNDED FOLLOWING
        ) AS max_after
    FROM heights
)
SELECT 
    COALESCE(
        SUM(
            GREATEST(0, LEAST(max_before, max_after) - height)
        ), 0
    ) AS total_trapped_water
FROM cte
WHERE max_before IS NOT NULL 
  AND max_after IS NOT NULL;