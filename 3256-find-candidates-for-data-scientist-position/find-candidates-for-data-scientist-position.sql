# Write your MySQL query statement below
with cte as
(
    select candidate_id
    from candidates 
    where skill in ('Python', 'Tableau', 'PostgreSQL')
    group by 1
    having count(*) = 3
)
select candidate_id from cte order by 1;