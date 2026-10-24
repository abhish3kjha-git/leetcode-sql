# Write your MySQL query statement below
with cte as
(
    select player_id, min(event_date) as first_day
    from activity
    group by player_id
),
cte2 as
(
    select first_day as install_dt, count(a.player_id) as installs, round(count(b.player_id)/count(a.player_id),2) as Day1_retention
    from cte a left join activity b on a.player_id = b.player_id and datediff(b.event_date , first_day) = 1
    group by 1
)
select * from cte2