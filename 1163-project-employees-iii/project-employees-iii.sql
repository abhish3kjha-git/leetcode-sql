# Write your MySQL query statement below
with cte as
(
    select project_id, a.employee_id,
    rank() over(partition by project_id order by experience_years desc) as rnm
    from project a join employee b on a.employee_id = b.employee_id
)
select project_id,  employee_id from cte where rnm = 1;