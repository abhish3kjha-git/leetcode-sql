# Write your MySQL query statement below
with cte as
(
    select employee_id from employees
    where manager_id = 1 and employee_id <> 1
),
cte2 as
(
    select employee_id from employees
    where manager_id in (select employee_id from cte)
),
cte3 as
(
    select employee_id from employees
    where manager_id in (select employee_id from cte2)
)
select * from cte3
union
select * from cte2
union
select * from cte