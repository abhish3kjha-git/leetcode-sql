# Write your MySQL query statement below
with cte as
(
    select 'failed' as period_state, fail_date as dt from failed
    where fail_date between '2019-01-01' and '2019-12-31' 

    union all

    select 'succeeded' as period_state, success_date as dt from Succeeded 
    where success_date between '2019-01-01' and '2019-12-31'
),
cte2 as
(
    select *, dt - interval row_number() over(partition by period_state order by dt) day as rnm
    from cte
)
select period_state, min(dt) as start_date , max(dt) as end_date from cte2
group by period_state, rnm
order by start_date