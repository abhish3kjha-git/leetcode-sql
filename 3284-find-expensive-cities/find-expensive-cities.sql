# Write your MySQL query statement below

with cte as
(
    select avg(price) as national_average from listings
),
cte2 as
(
    select city, avg(price) as city_avg from listings
    group by 1
) 
select city from cte2 where city_avg> (select national_average from cte)
order by 1