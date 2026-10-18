# Write your MySQL query statement below
with cte as
(
    select seat_id, free, seat_id - row_number() over(order by seat_id) as rnm
    from cinema
    where free = 1
),
cte2 as
(
    select rnm , min(seat_id) as first_seat_id, max(seat_id) as last_seat_id, count(*) as consecutive_seats_len
    from cte
    group by rnm
),
cte3 as
(
    select first_seat_id, last_seat_id, consecutive_seats_len, rank() over(order by consecutive_seats_len desc) as rnk
    from cte2
)
select first_seat_id, last_seat_id, consecutive_seats_len from cte3 where rnk = 1
order by first_seat_id