{{ config(materialized='table') }}
-- Este modelo representa la dimensión de clientes, que se construye a partir de la tabla de staging 'stg_customers'. Se seleccionan las columnas relevantes para la dimensión, como el identificador del cliente, su nombre, dirección y número de teléfono. Esta tabla se materializa como una tabla física en el almacén de datos para mejorar el rendimiento en las consultas que la utilicen.
SELECT
    customer_id,
    customer_name,
    address,
    phone_number
FROM {{ ref('stg_customers') }}
