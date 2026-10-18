# Write your MySQL query statement below
SELECT
    team_name,
    points,
    position,
    CASE 
        WHEN position <= CEIL((SELECT COUNT(*) FROM TeamStats) / 3.0)
        THEN 'Tier 1'

        WHEN position <= CEIL((SELECT COUNT(*) FROM TeamStats) * 2 / 3.0)
        THEN 'Tier 2'

        ELSE 'Tier 3'

    END AS tier
FROM (

    SELECT
        team_name,
        (wins * 3 + draws * 1) AS points,
        RANK() OVER(
            ORDER BY (wins * 3 + draws * 1) DESC
        ) AS position
    FROM TeamStats
    ) AS t

ORDER BY position, team_name
