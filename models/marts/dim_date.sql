{{ config(materialized='table') }}

with base_numbers as (
    -- Usamos un nombre de columna que no sea palabra reservada
    select 
        (row_number() over (order by null)) - 1 as offset_days
    from table(generator(rowcount => 3653))
),

date_spine as (
    select 
        dateadd(day, offset_days, '1990-01-01'::date) as date_day
    from base_numbers
)

select
    date_day as date_id,
    extract(year from date_day) as year_number, -- Cambiado para evitar conflictos
    extract(month from date_day) as month_number,
    extract(day from date_day) as day_number,
    extract(dayofweek from date_day) as day_of_week,
    case 
        when extract(dayofweek from date_day) in (0, 6) then true 
        else false 
    end as is_weekend
from date_spine