# Write your MySQL query statement below
with cte as
(
    select file_name,
    case when content like '% bull %' then 1 else 0 end as bull_cnt,
    case when content like '% bear %' then 1 else 0 end as bear_cnt
    from files 
),
cte2 as
(
    select 'bull' as word, sum(bull_cnt) as count from cte
    union
    select 'bear' as word, sum(bear_cnt) as count from cte
)
select * from cte2