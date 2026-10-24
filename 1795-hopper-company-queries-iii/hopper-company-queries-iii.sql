# Write your MySQL query statement below
with recursive cte as
(
    select 1 as mth
    union 
    select mth + 1 from cte
    where mth < 12
),
cte2 as
(
    select month(requested_at) as mth,
    sum(coalesce(ride_distance,0)) as dst, sum(coalesce(ride_duration,0)) as dur
    from rides a left join acceptedrides b on a.ride_id = b.ride_id
    where year(requested_at) = 2020
    group by 1
),
cte3 as
(
    select a.mth, sum(coalesce(dst, 0)) as dst, 
    sum(coalesce(dur, 0)) as dur
    from cte a left join cte2 b on a.mth = b.mth
    group by 1
),
cte4 as
(
    select mth, 
    round(avg(dst) over(order by mth rows between current row and 2 following),2) as average_ride_distance,
    round(avg(dur) over(order by mth rows between current row and 2 following),2) as average_ride_duration
    from cte3
    order by mth
)
-- select * from cte3
select mth as `month`, average_ride_distance, average_ride_duration from cte4 where mth<=10
order by 1