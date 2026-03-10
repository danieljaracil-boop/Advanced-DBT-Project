{% snapshot scd_customers %}

{{
    config(
      target_schema='snapshots',
      unique_key='customer_id',
      strategy='check',
      check_cols=['email', 'address', 'phone_number'],
    )
}}

select * from {{ ref('stg_customers') }}

{% endsnapshot %}