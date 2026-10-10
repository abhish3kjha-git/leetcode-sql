# Write your MySQL query statement below
with cte as
(
    select user1_id as usr, user2_id as frd from friendship where user1_id = 1
    union
    select user2_id as usr, user1_id as frd from friendship where user2_id = 1
),
cte2 as
(
    select distinct page_id as recommended_page from likes a join cte b on frd = user_id
    where page_id not in (select page_id from likes where user_id = 1)
)
select * from cte2;

-- where page_id not in (select page_id from likes where user_id)