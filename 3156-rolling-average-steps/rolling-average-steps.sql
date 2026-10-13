# Write your MySQL query statement below
# Write your MySQL query statement below
select user_id, steps_date, rolling_average from
(select user_id, steps_date,
round(avg(steps_count)over(PARTITION BY USER_ID ORDER BY steps_date ROWS BETWEEN 2 preceding and CURRENT ROW),2) rolling_average,
count(steps_count)over(PARTITION BY USER_ID ORDER BY steps_date RANGE BETWEEN INTERVAL 2 DAY preceding and CURRENT ROW) cnt
from Steps
order by 1,2)
a
where cnt>2