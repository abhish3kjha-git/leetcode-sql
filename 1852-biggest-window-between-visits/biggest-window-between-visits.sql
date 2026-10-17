# Write your MySQL query statement below
with cte as
(
    select user_id, datediff((ifnull(lead(visit_date) over(partition by user_id order by visit_date), '2021-01-01')), visit_date) as day_diff
    from uservisits
)
select user_id, max(day_diff) as biggest_window from cte
group by user_id
order by user_id