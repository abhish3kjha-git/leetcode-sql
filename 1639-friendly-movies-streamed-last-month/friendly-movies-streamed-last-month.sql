# Write your MySQL query statement below

select distinct title from content a join tvprogram b on a.content_id = b.content_id 
where program_date like '2020-06%' and kids_content = 'Y' and content_type = 'Movies'