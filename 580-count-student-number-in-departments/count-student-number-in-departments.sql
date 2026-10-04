# Write your MySQL query statement below

select dept_name, coalesce(count(student_id), 0) as student_number
from department a left join student b on a.dept_id = b.dept_id
group by 1
order by student_number desc, dept_name