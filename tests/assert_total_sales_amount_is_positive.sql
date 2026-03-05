-- Regla de negocio: El monto total de ventas por cliente 
-- en el modelo final nunca debe ser negativo.
select
    customer_key,
    total_spent
from {{ ref('fct_orders') }}
where total_spent < 0