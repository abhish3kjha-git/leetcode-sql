# Write your MySQL query statement below
with cte as
(
    select group_id, player, sum(score) as total_score
    from 
    (
    select first_player as player, group_id, first_score as score
    from matches a join players b on a.first_player = b.player_id
    
    union all

    select second_player as player, group_id, second_score as score
    from matches a join players b on a.first_player = b.player_id
    ) as a
    group by 1, 2
),
cte2 as
(
    select group_id, player, rank() over(partition by group_id order by total_score desc , player) as rnk
    from cte
)
select group_id, player as player_id from cte2 where rnk = 1