# Write your MySQL query statement below
WITH ranks AS (
    SELECT 
        *,
        CASE 
            WHEN gender = "female" THEN 1
            WHEN gender = "other" THEN 2
            ELSE 3
        END rank_gender,
        RANK() OVER (PARTITION BY gender ORDER BY user_id) rank_id
    FROM
        Genders
)
SELECT 
    user_id,
    gender
FROM
    ranks
ORDER BY
    rank_id,
    rank_gender 