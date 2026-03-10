-- tests/assert_order_date_is_recent.sql
select
    order_id,
    order_date
from {{ ref('stg_orders') }}
where order_date > current_date() or order_date < '2020-01-01'