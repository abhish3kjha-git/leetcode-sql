# Write your MySQL query statement below
with cte as
(
    select school_id, coalesce(min(score), -1) as score
    from schools a left join exam b on student_count<= capacity
    group by 1
)
select * from cte