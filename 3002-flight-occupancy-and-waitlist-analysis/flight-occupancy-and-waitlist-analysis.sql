# Write your MySQL query statement below
with cte as
(
    select flight_id, count(*) as bk
    from passengers
    group by 1
)
select a.flight_id, 
case when bk is null then 0
when bk> capacity then capacity
else bk end as booked_cnt,
case when bk is null then 0
when bk>capacity then bk - capacity
else 0 end as waitlist_cnt
from flights a left join cte b on a.flight_id = b.flight_id
order by flight_id