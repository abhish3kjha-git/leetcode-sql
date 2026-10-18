# Write your MySQL query statement below
with cte as
(
    select passenger_id as driver_id, count(*) as cnt from rides 
    where passenger_id in (select distinct driver_id from rides)
    group by 1
),
cte2 as
(
    select distinct driver_id, 0 as cnt from rides
    where driver_id not in (select driver_id from cte)
)
select * from cte2
union
select * from cte