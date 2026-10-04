# Write your MySQL query statement below
with cte as
(
    select question_id, 
    sum(case when answer_id is not null then 1 else 0 end) as ar,
    sum(case when answer_id is null then 1 else 0 end) as nar
    from surveylog
    group by 1
),
cte2 as
(
    select question_id,
    row_number() over(order by ar/nar desc, question_id) as rnm
    from cte
)
select question_id as survey_log from cte2 where rnm = 1;