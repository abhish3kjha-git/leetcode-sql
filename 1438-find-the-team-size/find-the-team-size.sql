# Write your MySQL query statement below

with cte as
(
    select team_id, count(distinct employee_id) as team_size
    from employee
    group by 1
)
select employee_id, team_size from cte a join employee b on a.team_id = b.team_id;