# Write your MySQL query statement below

with cte as
(
    select user_id,
    sum(case when loan_type = 'Mortgage' then 1 else 0 end) as mcount,
    sum(case when loan_type = 'Refinance' then 1 else 0 end) as rcount
    from loans
    group by user_id
)
select distinct user_id from cte where mcount>=1 and rcount>=1
order by 1;