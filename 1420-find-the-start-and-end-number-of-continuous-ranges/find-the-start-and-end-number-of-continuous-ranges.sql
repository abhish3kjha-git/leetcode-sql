# Write your MySQL query statement below
with cte as
(
    select log_id, log_id - row_number() over(order by log_id) as grp
    from logs
)
select min(log_id) as start_id, max(log_id) as end_id from cte
group by grp