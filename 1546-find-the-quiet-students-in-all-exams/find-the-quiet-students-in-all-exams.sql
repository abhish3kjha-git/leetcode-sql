# Write your MySQL query statement below
with cte as
(
    select exam_id, a.student_id, student_name, score, dense_rank() over(partition by exam_id order by score desc) as rnm1,
    dense_rank() over(partition by exam_id order by score) as rnm2
    from exam a join student b on a.student_id = b.student_id
),
cte2 as
(
    select distinct student_id from cte
    where rnm1 = 1 or rnm2 = 1
)
select distinct student_id, student_name from cte 
where student_id not in (select student_id from cte2)
order by 1