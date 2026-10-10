# Write your MySQL query statement below
with cte as
(
    select home_team_id as tid,
    home_team_goals as home_goal,
    away_team_goals as away_goal
    from matches
    union all
    select away_team_id as tid,
    away_team_goals as home_goal,
    home_team_goals as away_goal
    from matches
),
cte2 as
(
    select tid, count(*) as matches_played,
    sum(home_goal) as goal_for, 
    sum(away_goal) as goal_against, 
    sum(case when home_goal> away_goal then 3
    when home_goal = away_goal then 1
    else 0 end) as points 
    from cte
    group by tid
)
select team_name,
matches_played,
points,
goal_for,
goal_against,
(goal_for - goal_against) as goal_diff
from cte2 a join teams b on a.tid = team_id
 order by points desc, goal_diff desc, team_name