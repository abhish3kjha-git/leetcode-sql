# Write your MySQL query statement below
with cte as
(
    select a.employee_id, count(*) as overlapping_shifts
    from employeeshifts a join employeeshifts b on a.employee_id = b.employee_id AND a.start_time < b.end_time
    AND b.start_time < a.end_time
    AND a.start_time < b.start_time
    group by 1
    order by 1
)
select * from cte