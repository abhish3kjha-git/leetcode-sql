WITH ShiftPairs AS (
    -- Calculate pairwise overlap duration
    SELECT 
        s1.employee_id,
        TIMESTAMPDIFF(
            MINUTE, 
            s2.start_time, 
            LEAST(s1.end_time, s2.end_time)
        ) AS overlap_minutes
    FROM EmployeeShifts s1
    JOIN EmployeeShifts s2
      ON s1.employee_id = s2.employee_id
     AND DATE(s1.start_time) = DATE(s2.start_time)
     AND s1.start_time < s2.start_time
     AND s1.end_time > s2.start_time
),
TotalOverlap AS (
    SELECT 
        e.employee_id,
        COALESCE(SUM(p.overlap_minutes), 0) AS total_overlap_duration
    FROM (SELECT DISTINCT employee_id FROM EmployeeShifts) e
    LEFT JOIN ShiftPairs p ON e.employee_id = p.employee_id
    GROUP BY e.employee_id
),
ConcurrentShifts AS (
    -- At the moment s1 starts, count how many shifts are currently active
    SELECT 
        s1.employee_id,
        COUNT(s2.start_time) AS active_count
    FROM EmployeeShifts s1
    JOIN EmployeeShifts s2
      ON s1.employee_id = s2.employee_id
     AND DATE(s1.start_time) = DATE(s2.start_time)
     AND s2.start_time <= s1.start_time
     AND s2.end_time > s1.start_time
    GROUP BY s1.employee_id, s1.start_time
),
MaxConcurrent AS (
    SELECT 
        employee_id, 
        MAX(active_count) AS max_overlapping_shifts
    FROM ConcurrentShifts
    GROUP BY employee_id
)
SELECT 
    t.employee_id,
    COALESCE(m.max_overlapping_shifts, 1) AS max_overlapping_shifts,
    t.total_overlap_duration
FROM TotalOverlap t
LEFT JOIN MaxConcurrent m ON t.employee_id = m.employee_id
ORDER BY t.employee_id ASC;