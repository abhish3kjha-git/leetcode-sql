WITH cte AS (
    SELECT 
        state, 
        city, 
        CASE 
            WHEN SUBSTRING(state, 1, 1) = SUBSTRING(city, 1, 1) THEN 1 
            ELSE 0 
        END AS matched
    FROM cities
),
cte2 AS (
    SELECT 
        state, 
        GROUP_CONCAT(city order by city SEPARATOR ', ') AS cities, 
        SUM(matched) AS matching_letter_count  
    FROM cte
    GROUP BY state
    HAVING SUM(matched) > 0 and count(city)>=3
)
SELECT * FROM cte2
order by matching_letter_count desc, state