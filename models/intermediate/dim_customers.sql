{{ config(materialized='table') }}

SELECT
    customer_id,
    customer_name,
    address,
    phone_number
FROM {{ ref('stg_customers') }}