# Write your MySQL query statement below
with cte as
(
    select date_format(pay_date, '%Y-%m') as pay_month, sum(amount)/count(a.employee_id) as company_avg
    from salary a join employee b on a.employee_id = b.employee_id
    group by 1
),
cte2 as
(
    select date_format(pay_date, '%Y-%m') as pay_month, department_id, avg(amount) as dept_avg
    from salary a join employee b on a.employee_id = b.employee_id
    group by 1, 2
),
cte3 as
(
    select a.pay_month, department_id, 
    case when dept_avg> company_avg then 'higher'
    when dept_avg < company_avg then 'lower'
    else 'same' end as comparison
    from cte a join cte2 b on a.pay_month = b.pay_month
)
select * from cte3