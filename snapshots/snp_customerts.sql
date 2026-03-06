{% snapshot snp_customers %}

{{
    config(
      target_database='DBT_BTC_ANALYTICS', 
      target_schema='snapshots',
      unique_key='c_custkey',
      strategy='check',
      check_cols=['c_address', 'c_phone', 'c_acctbal'],
    )
}}

select * from {{ source('tpch_source', 'customer') }}
{% endsnapshot %}