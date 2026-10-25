with cte as
(
    select a.user_id as user1 , b.user_id as user2
    from listens a join listens b on a.user_id< b.user_id and a.song_id = b.song_id and a.`day` = b.`day`
    group by 1, 2, a.`day`
    having count(distinct a.song_id)>=3
),
cte3 as
(
    select * from cte
    where (user1, user2) not in (select * from friendship)
)
select user1 as user_id, user2 as recommended_id from cte3
union
select user2, user1 from cte3
