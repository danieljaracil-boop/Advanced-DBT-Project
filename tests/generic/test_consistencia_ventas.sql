select
    order_id,
    total_amount
from {{ ref('fct_orders') }} -- Ajusta al nombre de tu modelo de ventas
where total_amount < 0