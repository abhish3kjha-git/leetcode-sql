# Write your MySQL query statement below
with cte as
(
    select company_id, 
    case when max(salary) between 1000 and 10000 then 24
    when max(salary) > 10000 then 49
    else 0 end as tax
    from salaries
    group by company_id
),
cte2 as
(
    select a.company_id, employee_id, employee_name, round(salary - salary*tax/100, 0) as salary
    from salaries a join cte b on a.company_id = b.company_id
)
select * from cte2;