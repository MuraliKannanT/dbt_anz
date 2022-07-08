{# parameterize the following variables #}
{%- set size = 15 %}
{%- set type = 'BRASS' %}
{%- set region = 'EUROPE' -%}

select
    s_acctbal,
    s_name,
    n_name,
    p_partkey,
    p_mfgr,
    s_address,
    s_phone,
    s_comment
from
    {{ source('src', 'parts') }}, 
    {{ source('src', 'suppliers') }},
    {{ source('src', 'nations') }}, 
    {{ source('src', 'regions') }}

where
    p_size = {{ size }}
    and p_type like '%{{ type }}'
    and s_nationkey = n_nationkey
    and n_regionkey = r_regionkey
    and r_name = '{{ region }}'
    and p_supplycost = (
        select 
            min(p_supplycost)
        from
        {{ source('src', 'suppliers') }},
        {{ source('src', 'nations') }}, {{ source('src', 'regions') }}
        where
            s_nationkey = n_nationkey
            and n_regionkey = r_regionkey
            and r_name = '{{ region }}'
    )
order by
    s_acctbal desc,
    n_name,
    s_name,
    p_partkey