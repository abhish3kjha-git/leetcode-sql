# Write your MySQL query statement below
# Write your MySQL query statement below
-- select user_id, steps_date, rolling_average from
-- (select user_id, steps_date,
-- round(avg(steps_count)over(PARTITION BY USER_ID ORDER BY steps_date ROWS BETWEEN 2 preceding and CURRENT ROW),2) rolling_average,
-- count(steps_count)over(PARTITION BY USER_ID ORDER BY steps_date RANGE BETWEEN INTERVAL 2 DAY preceding and CURRENT ROW) cnt
-- from Steps
-- order by 1,2)
-- a
-- where cnt>2

with cte as
(
    select user_id, steps_count, steps_date,
    round(avg(steps_count) over(partition by user_id order by steps_date rows between 2 preceding and current row), 2) as rolling_average,
    count(steps_count) over(partition by user_id order by steps_date range between interval 2 day preceding and current row) as cnt
    from steps
)
select user_id, steps_date, rolling_average from cte
where cnt> 2
order by user_id, steps_date