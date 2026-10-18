# Write your MySQL query statement below
with cte as
(
    select team_id, name, points, dense_rank() over(order by points desc, name) as global_rank
    from teampoints
),
cte2 as
(
    select a.team_id, name, points + coalesce(points_change, 0) as changed_points, global_rank
    from cte a left join pointschange b on a.team_id = b.team_id
),
cte3 as
(
    select team_id, name, 
    cast(global_rank as signed) - cast(dense_rank() over(order by changed_points desc, name) as signed) as rank_diff
    from cte2
)
select * from cte3