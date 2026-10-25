# Write your MySQL query statement below
with cte as
(
    select project_id, a.employee_id, name as employee_name, workload as project_workload, 
    avg(workload) over(partition by team) as team_avg
    from project a join employees b on a.employee_id = b.employee_id
)
select employee_id as EMPLOYEE_ID, project_id As PROJECT_ID, employee_name as EMPLOYEE_NAME, project_workload as PROJECT_WORKLOAD from cte
where project_workload > team_avg
order by 1, 2