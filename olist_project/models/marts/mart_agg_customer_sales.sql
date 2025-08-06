{{
  config(
    materialized='table',
    unique_key='customer_id'
  )
}}

with customer_base as (
    select
        customer_id,
        customer_unique_id as customer_real_name 
    from {{ source('raw', 'olist_customers_dataset') }}
),

sales_data as (
    select
        customer_id,
        total_amount,
        last_purchase_date
    from {{ ref('mart_customer_sales') }}
)

select  
    c.customer_id,
    c.customer_real_name as customer_name,
    sum(s.total_amount) as sales_amount,
    max(s.last_purchase_date) as last_purchase_date,
    current_timestamp as etl_loaded_at
from 
    sales_data s
join 
    customer_base c on s.customer_id = c.customer_id
group by 
    c.customer_id, c.customer_real_name