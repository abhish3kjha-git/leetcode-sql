with trusted_contacts as (
    select con.user_id, 
        count(con.contact_email) as contacts_cnt, 
        count(cust.customer_id) as trusted_contacts_cnt
    from Contacts as con
        left join Customers as cust on con.contact_email = cust.email
    group by con.user_id
    
)

select 
    i.invoice_id,
    c.customer_name,
    i.price,
    coalesce(t.contacts_cnt, 0) as contacts_cnt,
    coalesce(t.trusted_contacts_cnt, 0) as trusted_contacts_cnt
from Invoices  as i
    left join trusted_contacts as t on  i.user_id  = t.user_id
    join Customers as c on i.user_id = c.customer_id
order by i.invoice_id