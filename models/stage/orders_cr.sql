with source as (

    select * from {{ ref('stg_orders') }}

),

changed as (

    select

order_id,
customer_id,
comment,
clerk_name,
total_price total_price_usd,
{{ dol_eur('total_price',2) }} total_price_eur,
status_code,
priority_code,
ship_priority,
order_date
    from source
)

select * from changed
