# Write your MySQL query statement below

with cte as
(
    select first_col , row_number() over(order by first_col) as rnm1
    from data
),
cte2 as
(
    select second_col, row_number() over(order by second_col desc) as rnm2
    from data
)
select first_col, second_col from cte a join cte2 b on a.rnm1 = b.rnm2;