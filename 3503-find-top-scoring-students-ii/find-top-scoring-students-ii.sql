WITH major_reqs AS (
    SELECT 
        major,
        COUNT(CASE WHEN mandatory = 'yes' THEN 1 END) AS total_mandatory
    FROM courses
    GROUP BY major
)
SELECT 
    e.student_id
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN courses c ON e.course_id = c.course_id
JOIN major_reqs mr ON s.major = mr.major
GROUP BY e.student_id, mr.total_mandatory
HAVING 
    -- Average GPA across ALL courses (including outside major) >= 2.5
    AVG(e.GPA) >= 2.5
    -- Took all mandatory courses in their major and got an 'A' in each
    AND COUNT(DISTINCT CASE 
        WHEN c.major = s.major AND c.mandatory = 'yes' AND e.grade = 'A' 
        THEN e.course_id 
    END) = mr.total_mandatory
    -- No mandatory course in their major had a grade other than 'A'
    AND COUNT(CASE 
        WHEN c.major = s.major AND c.mandatory = 'yes' AND e.grade <> 'A' 
        THEN 1 
    END) = 0
    -- Took at least 2 distinct electives in their major
    AND COUNT(DISTINCT CASE 
        WHEN c.major = s.major AND c.mandatory = 'no' AND e.grade IN ('A', 'B') 
        THEN e.course_id 
    END) >= 2
    -- No elective course in their major had a grade worse than 'B'
    AND COUNT(CASE 
        WHEN c.major = s.major AND c.mandatory = 'no' AND e.grade NOT IN ('A', 'B') 
        THEN 1 
    END) = 0
ORDER BY e.student_id ASC;