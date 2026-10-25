# Write your MySQL query statement below
with cte as
(
    select id, company, salary, row_number() over(partition by company order by salary) as rnm,
    count(*) over(partition by company) as cnt
    from 
    employee
)
select id, company, salary from cte
where rnm between cnt/2 and cnt/2 + 1
