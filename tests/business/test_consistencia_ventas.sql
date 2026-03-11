select
    order_id,
    total_order_amount
from {{ ref('fct_sales') }} 
where total_order_amount < 0