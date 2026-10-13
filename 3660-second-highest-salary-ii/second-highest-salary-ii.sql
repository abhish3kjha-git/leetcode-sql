# Write your MySQL query statement below
with cte as
(
    select emp_id, dept, dense_rank() over(partition by dept order by salary desc) as rnk
    from employees
)
select emp_id, dept from cte where rnk = 2
order by 1