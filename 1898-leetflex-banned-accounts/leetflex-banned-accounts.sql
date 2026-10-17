# Write your MySQL query statement below
with cte as
(
    select a.account_id from loginfo a join loginfo b
    on a.account_id = b.account_id and a.ip_address <> b.ip_address and b.login between a.login and a.logout
)
select distinct account_id from cte