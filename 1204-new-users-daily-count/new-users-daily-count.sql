# Write your MySQL query statement below

with cte as
(
    select user_id,  min(activity_date) as first_login
    from traffic
    where activity = 'login'
    group by user_id
)
select first_login as login_date,count(distinct user_id) as user_count from cte
where first_login <= '2019-06-30' and datediff('2019-06-30', first_login)<=90 
group by first_login
having count(user_id)>0

-- select login_date, count(1) user_count
-- from
-- (select user_id, min(activity_date) login_date
-- from traffic
-- where activity = 'login'
-- group by user_id) a
-- where login_date between date_add('2019-06-30', interval -90 day) and '2019-06-30'
-- group by login_date