with sales as (
    select 
        sale_id,
        customer_id,
        amount,
        sale_date
    from {{ ref('stg_orders') }} 
),

customers as (
    select 
        customer_id,
        customer_unique_id as customer_name
    from {{ ref('stg_customers') }}
),

customer_sales as (  
    select 
        c.customer_id,
        c.customer_name,
        sum(s.amount) as total_amount, 
        max(s.sale_date) as last_purchase_date,
        count(s.sale_id) as total_orders
    from sales s
    inner join customers c on s.customer_id = c.customer_id
    group by 1, 2
)

select * from customer_sales