# Write your MySQL query statement below
with cte as
(
    select distinct id, login_date from logins
),
cte2 as
(
    select id, login_date - interval row_number() over(partition by id order by login_date) day as rnm
    from cte
),
cte3 as
(
    select distinct id
    from cte2 
    group by id, rnm
    having count(*)>=5
)
select a.id, name from cte3 a join accounts b on a.id = b.id order by 1;