with recursive cte as
(
    select case when join_date < '2020-01-01' then 1 else month(join_date) end as mth,
    count(distinct driver_id) as active_driver
    from drivers
    where join_date <= '2020-12-31'
    group by 1
),
cte2 as
(
    select month(requested_at) as mth,
    count(distinct a.ride_id) as accepted_ride
    from rides a join acceptedRides b on a.ride_id = b.ride_id
    where year(requested_at) = 2020
    group by 1
),
cte3 as
(
    select 1 as mth
    union 
    select mth+1 from cte3
    where mth< 12
),
cte4 as
(
    select a.mth, coalesce(active_driver, 0) as active_drivers, coalesce(accepted_ride, 0) as accepted_rides
    from cte3 a left join cte b on a.mth = b.mth
    left join cte2 c on a.mth = c.mth
)
-- select * from cte2
select mth as `month`, sum(active_drivers) over(order by mth) as active_drivers, accepted_rides from cte4
order by 1