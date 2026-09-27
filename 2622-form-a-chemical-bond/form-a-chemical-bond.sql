# Write your MySQL query statement below
with cte as
(
    select symbol as metal from elements where type = 'Metal'
),
cte2 as
(
    select symbol as nonmetal from elements where type = 'Nonmetal'
)
select metal, nonmetal from cte, cte2