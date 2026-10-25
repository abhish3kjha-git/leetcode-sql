# Write your MySQL query statement below
with cte as
(
    select *, row_number() over(partition by user_id order by session_start, session_end) as rnm,
    sum(case when session_type = 'Streamer' then 1 else 0 end) over(partition by user_id) as sm
    from sessions
)
select distinct user_id, sm as sessions_count from cte
where rnm = 1 and session_type = 'Viewer' and sm>0
order by 2 desc, 1 desc