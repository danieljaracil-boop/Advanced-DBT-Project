{% snapshot snp_customers %}

{{
    config(
      target_database='tu_base_de_datos', -- Sustituye por tu DB de Snowflake
      target_schema='snapshots',
      unique_key='c_custkey',
      strategy='check',
      check_cols=['c_address', 'c_phone', 'c_acctbal'],
    )
}}

select * from {{ source('tpch', 'customer') }}

{% endsnapshot %}