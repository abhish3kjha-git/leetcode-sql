# Write your MySQL query statement below

/*
1. obtained the purchase date for every friday of Nov 2023 month : recursive cte
2. left join on purchases

*/

with recursive nov_fridays as (

    select '2023-11-01' as purchase_date
    union all 
    select purchase_date + interval 1 Day as purchase_date
    from nov_fridays
    where purchase_date < '2023-11-30'
)

select floor(dayofmonth(nf.purchase_date)/7)+1 as week_of_month,
       nf.purchase_date,
       ifnull(sum(p.amount_spend),0) as total_amount
 from nov_fridays nf 
 left join Purchases p on p.purchase_date = nf.purchase_date
 where dayname(nf.purchase_date)='Friday'
 group by 1,2
 order by 1