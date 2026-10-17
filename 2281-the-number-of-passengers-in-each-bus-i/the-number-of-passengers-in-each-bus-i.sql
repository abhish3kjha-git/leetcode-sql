# Write your MySQL query statement below
with cte as
(
    select passenger_id, a.arrival_time as p_arrival, min(b.arrival_time) as bus_arrival 
    from passengers a, buses b
    where b.arrival_time>= a.arrival_time
    group by 1, 2
),
cte2 as
(
    select bus_arrival, count(passenger_id) as num_p
    from cte
    group by 1
)
select bus_id, ifnull(num_p, 0) as passengers_cnt from cte2 right join buses on bus_arrival = arrival_time
order by 1