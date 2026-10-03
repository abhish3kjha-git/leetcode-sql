# Write your MySQL query statement below
with cte as
(
    select candidateId, count(id) as vc
    from vote
    group by 1
    order by vc desc
    limit 1
)
select name from candidate where id = (select candidateId from cte);