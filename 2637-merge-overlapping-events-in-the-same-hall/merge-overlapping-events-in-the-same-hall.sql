WITH rollingcalcs AS (
    SELECT hall_id, start_day, end_day, 
        MIN(start_day) OVER(PARTITION BY hall_id ORDER BY start_day, end_day ROWS BETWEEN UNBOUNDED PRECEDING and 1 PRECEDING) as min_start_day,
        MAX(end_day) OVER(PARTITION BY hall_id ORDER BY start_day, end_day ROWS BETWEEN UNBOUNDED PRECEDING and 1 PRECEDING) as max_end_day,
    (CASE WHEN start_day > MAX(end_day) OVER(PARTITION BY hall_id ORDER BY start_day, end_day ROWS BETWEEN UNBOUNDED PRECEDING and 1 PRECEDING)
        or MAX(end_day) OVER(PARTITION BY hall_id ORDER BY start_day, end_day ROWS BETWEEN UNBOUNDED PRECEDING and 1 PRECEDING) IS NULL
        THEN 1 
        ELSE 0
        END) as overlaps
    FROM HallEvents
), addgroups as (
    SELECT hall_id, start_day, end_day, SUM(overlaps) OVER(PARTITION BY hall_id ORDER BY start_day, end_day) as summed
    FROM rollingcalcs 
)

SELECT hall_id, MIN(start_day) as start_day, MAX(end_day) as end_day
FROM addgroups
GROUP BY hall_id, summed
ORDER BY hall_id, start_day