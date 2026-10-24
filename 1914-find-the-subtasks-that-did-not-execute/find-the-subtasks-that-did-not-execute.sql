# Write your MySQL query statement below
with recursive cte as
(
    select task_id, 1 as series from tasks

    union all

    select task_id, series + 1 from cte a
    where series < (select subtasks_count from tasks b where b.task_id = a.task_id)
)
select a.task_id,a.series as subtask_id from cte a left join executed b on a.task_id = b.task_id and a.series = b.subtask_id
where b.subtask_id is null