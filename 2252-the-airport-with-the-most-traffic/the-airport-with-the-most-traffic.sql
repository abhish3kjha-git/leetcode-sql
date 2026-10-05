# Write your MySQL query statement below

with cte as
(
    select departure_airport as airport, flights_count from flights
    union all
    select arrival_airport as airport, flights_count from flights
),
cte2 as
(
    select airport, sum(flights_count) as total
    from cte
    group by 1
),
cte3 as
(
    select airport, rank() over(order by total desc) as rnk
    from cte2    
)
select airport as airport_id from cte3 where rnk = 1;