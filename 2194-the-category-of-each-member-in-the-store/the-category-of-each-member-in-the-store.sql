# Write your MySQL query statement below
with cte as
(
    select a.member_id,visit_id, name, 
    case when b.member_id is not null then 1 else 0 end as visited
    from members a left join visits b on a.member_id = b.member_id
),
cte2 as
(
    select member_id, name,  
    ifnull(sum(case when b.visit_id is not null then 1 else 0 end)*100/sum(visited),-1) as rate
    from cte a left join purchases b on a.visit_id = b.visit_id
    group by 1,2
), 
cte3 as
(
    select member_id, name,
    case when rate>=80 then "Diamond"
    when rate >=50 and rate < 80 then "Gold"
    when rate < 50 and rate>=0 then "Silver"
    else "Bronze" end as category
    from cte2
)
select * from cte3