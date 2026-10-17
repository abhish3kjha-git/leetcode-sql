# Write your MySQL query statement below
with cte as
(
    select student_id, assignment1 + assignment2 + assignment3 as assignment
    from scores
)
select max(assignment) - min(assignment) as difference_in_score from cte