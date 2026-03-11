{{ config(materialized='table') }}

-- Ahora este modelo consume del snapshot para garantizar la trazabilidad histórica (SCD Tipo 2)
SELECT
    customer_id,
    customer_name,
    address,
    phone_number,
    dbt_valid_from, -- Columnas automáticas del snapshot
    dbt_valid_to,
    dbt_scd_id
FROM {{ ref('scd_customers') }}
WHERE dbt_valid_to IS NULL -- Esto selecciona solo los registros vigentes
