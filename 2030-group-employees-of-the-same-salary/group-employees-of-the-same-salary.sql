# Write your MySQL query statement below
with cte as
(
    select employee_id, name, salary, count(employee_id) over(partition by salary) as cnt
    from employees
),
cte2 as
(
    select employee_id, name, salary
    from cte
    where cnt > 1
)
select *, dense_rank() over(order by salary) as team_id
from cte2
order by team_id, employee_id