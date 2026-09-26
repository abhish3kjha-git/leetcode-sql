# Write your MySQL query statement below
with cte as
(
    select ad_id, round(sum(case when action='Clicked' then 1 else 0 end)*100/count(action), 2) as ctr
    from ads
    where action <> 'Ignored'
    group by 1
    order by ctr desc
)
select * from cte
union
select distinct ad_id, 0 as ctr from ads where ad_id not in (select ad_id from cte)
order by ctr desc, ad_id ;