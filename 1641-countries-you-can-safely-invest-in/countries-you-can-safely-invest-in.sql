# Write your MySQL query statement below
with cte as
(
    select id, name from country a join
    (select id, substring(phone_number, 1, 3) as cc
    from person) b on a.country_code = b.cc
),
cte2 as
(
    select ((sum(duration)))/count(*) as global_avg from calls
),
cte3 as
(
    select name, avg(duration) as pavg from
    (
        select caller_id as cid , duration from calls
        union all
        select callee_id as cid, duration from calls
    ) as o join cte b on cid = id  
    group by name 
)
select name as country from cte3 where pavg> (select global_avg from cte2)