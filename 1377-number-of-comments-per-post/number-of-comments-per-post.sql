# Write your MySQL query statement below

with cte as
(
    select distinct sub_id as dsub from submissions where parent_id is null
)
select dsub as post_id, coalesce(count(distinct sub_id), 0) as number_of_comments
from cte a left join submissions b on a.dsub = b.parent_id
group by 1
order by 1