# Write your MySQL query statement below
with cte as
(
    select passenger_id, a.flight_id, capacity - cast(row_number() over(partition by flight_id order by booking_time)as signed) as rnm
    from passengers a left join flights b on a.flight_id = b.flight_id
),
cte2 as
(
    select *, case when rnm>=0 then 'Confirmed' else 'Waitlist' end as Status
    from cte
)
select passenger_id, status from cte2
order by 1