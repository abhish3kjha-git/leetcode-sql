# Write your MySQL query statement below

with cte as
(
    select distinct session_id from playback a join ads b on a.customer_id = b.customer_id and `timestamp` between start_time and end_time
)
select distinct session_id from playback where session_id not in (select * from cte)