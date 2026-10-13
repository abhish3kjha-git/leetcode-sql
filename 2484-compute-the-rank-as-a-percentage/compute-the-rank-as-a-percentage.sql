# Write your MySQL query statement below
with cte as
(
    select student_id, department_id, rank() over(partition by department_id order by mark desc) as rnk,
    count(student_id) over(partition by department_id) as cnt
    from students
)
select student_id, department_id, ifnull(round((rnk-1)*100/(cnt-1), 2),0) as percentage from cte