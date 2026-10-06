# Write your MySQL query statement below
with cte as
(
    select event_type, avg(occurrences ) as event_avg
    from events
    group by 1
),
cte2 as
(
    select business_id
    from events a join cte b on a.event_type = b.event_type
    where occurrences> event_avg
    group by 1
    having count(*)>1
)
select * from cte2;