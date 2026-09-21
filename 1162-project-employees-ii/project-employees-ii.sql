# Write your MySQL query statement below

with cte as
(
    select project_id, count(distinct employee_id) as cnt_emp from project 
    group by project_id
),
rnk as
(
    select project_id, rank() over(order by cnt_emp desc) as prank
    from cte
)
select project_id from rnk where prank =1;
