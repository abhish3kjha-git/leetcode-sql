# Write your MySQL query statement below
with cte as
(
    select a.team_name, pass_from, pass_to, time_stamp,
    case when a.team_name = b.team_name then 1 else 0 end as stk
    from passes p join teams a on p.pass_from = a.player_id
    join teams b on p.pass_to = b.player_id
),
cte2 as
(
    select *, sum(case when stk = 0 then 1 else 0 end) over(partition by team_name order by time_stamp) as grp
    from cte
),cte3 as
(
    select team_name, grp, count(*) as streak_length from cte2
    where stk = 1
    group by 1, 2
)
select team_name, max(streak_length) as longest_streak
from cte3
group by 1
order by 1