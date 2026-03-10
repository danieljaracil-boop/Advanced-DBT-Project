{% snapshot scd_customers %}

{{
    config(
      target_database='DBT_BTC_ANALYTICS',
      target_schema='development_snapshots',
      unique_key='customer_id',
      strategy='check',
      check_cols=['nation_id', 'address', 'phone_number'],
    )
}}

select * from {{ ref('stg_customers') }}

{% endsnapshot %}