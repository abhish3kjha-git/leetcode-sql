# Write your MySQL query statement below
with cte as
(
    select user1 as usr, user2 as friend from friends
    union all
    select user2 as usr, user1 as friend from friends
),
cte2 as
(
    select count(*) as tot from
    (select distinct user1 from friends
    union 
    select distinct user2 from friends) o
)
select usr as user1, round(count(distinct friend)*100/(select tot from cte2) , 2) as percentage_popularity from cte
group by 1
order by 1