# Write your MySQL query statement below
with cte as
(
    select task_id, assignee_id, date_format(submit_date, '%W') as week_day from tasks
)
select count(case when week_day in ('Sunday', 'Saturday') then 1 end) as weekend_cnt,
count(case when week_day not in ('Sunday', 'Saturday') then 1 end) as working_cnt 
from cte