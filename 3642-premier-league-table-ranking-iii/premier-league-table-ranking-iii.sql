# Write your MySQL query statement below
with cte as
(
    select season_id, team_id, team_name, 
    sum(wins * 3 + draws ) as points,
    sum(goals_for) - sum(goals_against) as goal_difference
    from seasonstats
    group by 1, 2, 3
)
select *, dense_rank() over(partition by season_id order by points desc, goal_difference desc, team_name) as position from cte
order by season_id, `position`, team_name