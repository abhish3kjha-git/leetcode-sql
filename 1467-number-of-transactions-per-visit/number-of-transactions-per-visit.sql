# Write your MySQL query statement below
with recursive cte as
(
    select a.user_id, visit_date, transaction_date, case when transaction_date is null then 0 else 1 end as txn
    from visits a left join transactions b on a.user_id = b.user_id and a.visit_date = b.transaction_date
),
cte2 as
(
    select  user_id, visit_date, count(case when txn <> 0 then 1 end) as number_of_txn
    from cte
    group by user_id, visit_date
),
cte3 as
(
    select number_of_txn as transactions_count, count(*) as visits_count
    from cte2
    group by 1
),
cte4 as
(
    select 0 as transactions_count 

    union all

    select 1+transactions_count from cte4
    where transactions_count <(select max(transactions_count) from cte3)
)
select a.transactions_count, coalesce(visits_count, 0) as visits_count from cte4 a left join cte3 b on a.transactions_count = b.transactions_count
order by 1