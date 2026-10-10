# Write your MySQL query statement below
with cte as
(
    select a.apple_count + coalesce(b.apple_count,0) as apple_count,
    a.orange_count + coalesce(b.orange_count, 0) as orange_count
    from boxes a left join chests b on a.chest_id = b.chest_id
)
select sum(apple_count) as apple_count, sum(orange_count) as orange_count from cte;