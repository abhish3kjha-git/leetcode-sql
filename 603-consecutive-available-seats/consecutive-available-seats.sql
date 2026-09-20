# Write your MySQL query statement below

with cte as
(
select seat_id,
free,
lag(free) over(order by seat_id) as prev,
lead(free) over(order by seat_id) as next
from cinema
),
cte2 as
(
    select seat_id from cte
    where free != 0 and (prev = 1 or next = 1)
)
select * from cte2 order by seat_id;

