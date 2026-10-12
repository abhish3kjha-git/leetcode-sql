# Write your MySQL query statement below
with cte as
(
    select gold_medal as user_id
    from contests
    group by 1
    having count(distinct contest_id)>=3
),
cte2 as
(
    select gold_medal as user_id, contest_id from contests
    union all
    select silver_medal as user_id, contest_id from contests
    union all
    select bronze_medal as user_id, contest_id from contests
),
cte3 as
(
    select user_id, contest_id - row_number() over(partition by user_id order by contest_id) as grp
    from cte2
),
cte4 as
(
    select user_id from cte3
    group by grp, user_id
    having count(*)>=3
    union
    select user_id from cte
)
select name, mail from cte4 a join users b on a.user_id = b.user_id