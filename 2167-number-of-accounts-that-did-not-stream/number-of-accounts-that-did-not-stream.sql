# Write your MySQL query statement below
with cte as
(
    select a.account_id, b.account_id as stream_id from
    (select account_id from subscriptions 
    where start_date like '2021%' or end_date like '2021%') a left join
    (
        select account_id from streams 
        where stream_date like '2021%'
    ) b
    on a.account_id = b.account_id
)
select count(distinct account_id) as accounts_count from cte where stream_id is null