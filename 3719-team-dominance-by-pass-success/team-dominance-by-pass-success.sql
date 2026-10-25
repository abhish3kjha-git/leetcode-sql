# Write your MySQL query statement below
with cte as
(
    select a.team_name,
    case when time_stamp <= '45:00' then 1 else 2 end as half_number,
    sum(case when a.team_name = b.team_name then 1 else -1 end) as dominance
    from teams a join passes p on a.player_id = p.pass_from
    join teams b on b.player_id = p.pass_to
    group by 1, 2

)
select * from cte
order by team_name, half_number

-- SELECT
--     t1.team_name,

--     CASE 
--         WHEN p.time_stamp <= '45:00' THEN 1
--         ELSE 2
--     END AS half_number,

--     SUM(
--         CASE
--             WHEN t1.team_name = t2.team_name THEN 1
--             ELSE -1
--         END
--     ) AS dominance
    
-- FROM Teams t1

-- JOIN Passes p ON t1.player_id = p.pass_from

-- JOIN Teams t2 ON t2.player_id = p.pass_to

-- GROUP BY 1, 2
-- ORDER BY 1, 2
