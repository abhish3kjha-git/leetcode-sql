# Write your MySQL query statement below
with cte as
(
    select city, hour(call_time) as hr, count(*) as number_of_calls
    from calls
    group by 1, 2
),
cte2 as
(
    select *, rank() over(partition by city order by number_of_calls desc) as rnk
    from cte
)
select city, hr as peak_calling_hour, number_of_calls from cte2 where rnk = 1
order by peak_calling_hour desc, city desc