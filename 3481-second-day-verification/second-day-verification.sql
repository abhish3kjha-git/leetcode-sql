# Write your MySQL query statement below

select user_id from emails a join texts b on a.email_id = b.email_id
where signup_action = 'Verified' and datediff(action_date, signup_date) =1
order by 1;