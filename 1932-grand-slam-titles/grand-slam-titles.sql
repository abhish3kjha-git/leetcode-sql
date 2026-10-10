# Write your MySQL query statement below
with cte as
(
    select wimbledon as pid from Championships
    union all
    select fr_open as pid from Championships
    union all
    select us_open as pid from Championships
    union all
    select au_open as pid from Championships
)
select player_id, player_name, count(*) as grand_slams_count
from cte a join players b on a.pid = b.player_id
group by 1,2