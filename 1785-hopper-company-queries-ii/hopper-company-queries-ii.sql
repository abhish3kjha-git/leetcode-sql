with recursive cte3 as (
    select 1 as mth
    union all
    select mth + 1 from cte3
    where mth < 12
),
cte as (
    select 
        case when join_date < '2020-01-01' then 1 else month(join_date) end as mth,
        count(driver_id) as active_driver
    from Drivers
    where join_date <= '2020-12-31'
    group by 1
),
cte2 as (
    select 
        month(r.requested_at) as mth,
        count(distinct ar.driver_id) as working_drivers
    from Rides r 
    join AcceptedRides ar on r.ride_id = ar.ride_id
    where year(r.requested_at) = 2020
    group by 1
),
cte4 as (
    select 
        m.mth, 
        coalesce(d.active_driver, 0) as new_drivers, 
        coalesce(w.working_drivers, 0) as working_drivers
    from cte3 m 
    left join cte d on m.mth = d.mth
    left join cte2 w on m.mth = w.mth
)
select 
    mth as month,
    case 
        when sum(new_drivers) over (order by mth) = 0 then 0.00
        else round(working_drivers * 100.0 / sum(new_drivers) over (order by mth), 2)
    end as working_percentage
from cte4
order by month;