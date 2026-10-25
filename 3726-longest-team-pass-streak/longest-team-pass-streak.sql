WITH pass_data AS (
    SELECT
        p.time_stamp,
        t1.team_name,
        CASE
            WHEN t1.team_name = t2.team_name THEN 1
            ELSE 0
        END AS successful
    FROM Passes p
    JOIN Teams t1
        ON p.pass_from = t1.player_id
    JOIN Teams t2
        ON p.pass_to = t2.player_id
),

streaks AS (
    SELECT
        *,
        SUM(CASE WHEN successful = 0 THEN 1 ELSE 0 END)
        OVER (
            PARTITION BY team_name
            ORDER BY time_stamp
        ) AS grp
    FROM pass_data
),

counts AS (
    SELECT
        team_name,
        grp,
        COUNT(*) AS streak_length
    FROM streaks
    WHERE successful = 1
    GROUP BY team_name, grp
)

-- select * from streaks
SELECT
    team_name,
    MAX(streak_length) AS longest_streak
FROM counts
GROUP BY team_name
ORDER BY team_name
