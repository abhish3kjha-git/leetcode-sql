# Write your MySQL query statement below
with cte as
(
    select host_team as team_name,
    case when host_goals> guest_goals then 3
    when host_goals < guest_goals then 0
    else 1 end as num_points from matches
    union all
    select guest_team,
    case when guest_goals>host_goals then 3
    when guest_goals<host_goals then 0
    else 1 end as num_points from matches
),
cte2 as
(
    select team_name as id, sum(num_points) as num_points
    from cte
    group by 1
)
select team_id, team_name, coalesce(num_points,0) as num_points 
from cte2 a right join teams b on a.id = b.team_id
order by num_points desc, team_id