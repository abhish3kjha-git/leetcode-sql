# Write your MySQL query statement below
with cte as
(
    select a.driver_id, fuel_type, round(sum(rating)/count(*),2) as avg_rating, sum(`distance`) as `distance`, max(accidents) as accidents
    from vehicles a join trips b on a.vehicle_id = b.vehicle_id
    join drivers c on a.driver_id = c.driver_id
    group by 1,2
),
cte2 as
(
    select *, rank() over(partition by fuel_type order by avg_rating desc, distance desc, accidents) as rnk
    from cte
)

select fuel_type, driver_id, avg_rating as rating, `distance` from cte2 where rnk = 1