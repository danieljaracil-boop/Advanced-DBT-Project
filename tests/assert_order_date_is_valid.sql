-- Regla de negocio: La fecha del pedido no puede ser futura
-- y debe ser posterior a la fundación de la empresa (ej. 1990)
select
    order_id,
    order_date
from {{ ref('stg_orders') }}
where order_date > current_date
   or order_date < '1990-01-01'