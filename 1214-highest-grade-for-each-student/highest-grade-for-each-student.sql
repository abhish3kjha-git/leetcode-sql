# Write your MySQL query statement below
with cte as
(
    select *, rank() over(partition by student_id order by grade desc, course_id) as rnk
    from enrollments
)
select student_id, course_id, grade from cte where rnk =1;