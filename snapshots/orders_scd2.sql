
{% snapshot orders_snapshot %}

{{
    config(
      target_database='mkmart-dbt',
      target_schema='dbt_muralikannant',
      unique_key='o_orderkey',
      strategy='timestamp',
      updated_at='updtime'
    )
}}

select * from {{ source('src', 'chkorders') }}

{% endsnapshot %}