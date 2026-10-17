# Write your MySQL query statement below
with cte as
(
    select *, rank() over(partition by city_id order by degree desc, day) as rnk
    from weather
)
select city_id, day, degree from cte where rnk = 1