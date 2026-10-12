# Write your MySQL query statement below
with cte as
(
    select least(from_id, to_id) as person1,
    greatest(from_id, to_id) as person2,
    duration
    from calls
),
cte2 as
(
    select person1, person2, count(*) as call_count, sum(duration) as total_duration
    from cte
    group by 1, 2
)
select * from cte2