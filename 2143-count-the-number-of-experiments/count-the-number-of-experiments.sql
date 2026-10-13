# Write your MySQL query statement below
with cte as
(
    select 'Android' as platform
    union
    select 'IOS' as platform
    union 
    select 'Web' as platform
),
cte2 as
(
    select 'Reading' as experiment_name
    union
    select 'Sports' as experiment_name
    union
    select 'Programming' as experiment_name
),
cte3 as
(
    select platform, experiment_name, count(*) as num_experiments
    from experiments
    group by 1, 2
),
cte4 as
(
    select platform, experiment_name from cte, cte2
)
select a.platform, a.experiment_name, coalesce(num_experiments, 0) as num_experiments
from cte4 a left join cte3 b on a.platform = b.platform and a.experiment_name = b.experiment_name

