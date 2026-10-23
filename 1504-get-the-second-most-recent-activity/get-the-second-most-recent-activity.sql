# Write your MySQL query statement below
with cte as
(
    select *, rank() over(partition by username order by startDate desc, endDate desc) as rnk
    from useractivity
)
select username, activity, startDate, endDate from cte
where (username, rnk) in (select username, max(rnk) as rnk from cte where rnk<=2 group by 1)