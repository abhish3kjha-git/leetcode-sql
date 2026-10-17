# Write your MySQL query statement below
with cte as
(
    select age_bucket, activity_type, time_spent from activities a join age b on a.user_id = b.user_id
),
cte2 as
(
    select age_bucket, 
    round(sum(case when activity_type = 'send' then time_spent else 0 end)*100/sum(time_spent),2) as send_perc
    from cte
    group by 1
)
select age_bucket, send_perc, 100 - send_perc as open_perc from cte2