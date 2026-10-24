# Write your MySQL query statement below
with cte as
(
    select country, sum(points) as points, winery, dense_rank() over(partition by country order by sum(points) desc, winery) as drnk
    from wineries
    group by country, winery
),
cte2 as
(
    select country, concat(winery, ' (', points , ')') as top_winery 
    from cte
    where drnk = 1
),
cte3 as
(
    select country, concat(winery, ' (', points , ')') as second_winery 
    from cte
    where drnk = 2
),
cte4 as
(
    select country, concat(winery, ' (', points , ')') as third_winery 
    from cte
    where drnk = 3
),
cte5 as
(
    select distinct a.country , top_winery, ifnull(second_winery, 'No second winery') as second_winery, 
    ifnull(third_winery, 'No third winery') as third_winery
    from wineries a left join cte2 b on a.country = b.country
    left join cte3 c on a.country = c.country
    left join cte4 d on a.country = d.country
)
select * from cte5
order by country