# Write your MySQL query statement below
with cte as
(
    select interview_id
    from rounds
    group by 1
    having sum(score)> 15
)
select candidate_id from candidates
where interview_id in (select interview_id from cte) and years_of_exp >= 2