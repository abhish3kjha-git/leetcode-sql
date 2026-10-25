# Write your MySQL query statement below
select distinct user1_id,user2_id from friendship f join listens l1 on f.user1_id=l1.user_id 
join listens l2 on f.user2_id=l2.user_id
where l1.song_id=l2.song_id and l1.day=l2.day
group by 1,2,l1.day
having count(distinct l1.song_id)>=3
