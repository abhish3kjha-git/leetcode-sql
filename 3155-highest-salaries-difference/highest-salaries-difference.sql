# Write your MySQL query statement below
with cte as
(
    select max(salary) as mx1 from salaries where department = 'Marketing'
),
cte2 as
(
    select max(salary) as mx2 from salaries 
    where department = 'Engineering'
)
select abs(mx1 - (select mx2 from cte2)) as salary_difference from cte;