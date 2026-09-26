# Write your MySQL query statement below

with cte as
(
    select country_id, 
    case when avg(weather_state)<=15 then 'Cold'
    when avg(weather_state)>=25 then 'Hot'
    else 'Warm' end as weather_type
    from weather
    where `day` between '2019-11-01' and '2019-11-30'
    group by 1
)
select country_name , weather_type from cte a join countries b on a.country_id = b.country_id