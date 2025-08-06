{{
  config(
    materialized = 'view',
    unique_key = 'sale_id'
  )
}}

with base_payments as (
    select 
        order_id,
        payment_sequential,
        payment_value,
        payment_type,
        payment_installments
    from {{ source('raw', 'olist_order_payments_dataset') }}
),

payments_dedup as (
    select 
        order_id,
        payment_value,
        payment_type,
        payment_installments,
        row_number() over(
            partition by order_id 
            order by payment_sequential desc, payment_value desc
        ) as rn
    from base_payments
    where payment_value > 0
),

orders as (
    select 
        order_id, 
        customer_id,
        order_purchase_timestamp
    from {{ source('raw', 'olist_orders_dataset') }}
)

select
    p.order_id as sale_id,
    o.customer_id,
    cast(p.payment_value as decimal(10,2)) as amount,
    date(o.order_purchase_timestamp) as sale_date,
    p.payment_type,
    p.payment_installments
from payments_dedup p
join orders o on p.order_id = o.order_id
where p.rn = 1 