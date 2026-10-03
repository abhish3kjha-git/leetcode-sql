# Write your MySQL query statement below

select 
    tweet_id 
from tweets
where length(content) > 140
or char_length(content) - char_length(replace(content, '@', '')) > 3
or char_length(content) - char_length(replace(content, '#', '')) > 3