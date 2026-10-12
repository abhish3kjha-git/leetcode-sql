SELECT
    s.student_id
FROM students s
JOIN courses c
    ON s.major = c.major
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
    AND c.course_id = e.course_id
GROUP BY s.student_id
HAVING SUM(e.grade = 'A') = COUNT(c.course_id)
ORDER BY s.student_id