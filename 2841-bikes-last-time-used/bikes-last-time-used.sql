# Write your MySQL query statement below

select bike_number, max(end_time) as end_time from bikes group by 1 order by end_time desc