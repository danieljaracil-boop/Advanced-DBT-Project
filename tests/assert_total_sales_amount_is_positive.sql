-- Regla de negocio: El monto total de ventas por cliente 
-- en el modelo final nunca debe ser negativo.
select
    customer_key,
    total_order_amount as total_spent
from {{ ref('fct_sales') }}
where total_spent < 0