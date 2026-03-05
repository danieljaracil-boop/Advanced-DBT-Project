-- Regla de negocio: La fecha del pedido no puede ser futura
-- y debe ser posterior a la fundación de la empresa (ej. 1990)
select
    o_orderkey,
    o_orderdate
from {{ ref('stg_orders') }}
where o_orderdate > current_date
   or o_orderdate < '1990-01-01'