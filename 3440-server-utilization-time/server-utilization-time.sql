# Write your MySQL query statement below
WITH sessions AS (
    SELECT
        *,
        LEAD(status_time) OVER(
            PARTITION BY server_id
            ORDER BY status_time
        ) AS next_time
    FROM Servers
)

SELECT
    FLOOR(
        SUM(
            TIMESTAMPDIFF(
                SECOND, 
                status_time,
                next_time
            )
        ) / 86400
    ) AS total_uptime_days
FROM sessions
WHERE session_status = 'start' 

