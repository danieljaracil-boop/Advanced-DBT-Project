select
    order_id,
    order_date
from {{ ref('stg_orders') }}
where order_date > current_date()
   or order_date < '1990-01-01'