# Write your MySQL query statement below
with cte as 
(
    select distinct sender_id, send_to_id from FriendRequest
),
cte2 as 
(
    select distinct requester_id, accepter_id from RequestAccepted
)
select round(ifnull(count(*)/(select count(*) from cte),0),2) as accept_rate from cte2;