{{ config(materialized='table') }}

with raw_generated_dates as (
    -- Generamos 3653 filas (aprox 10 años) de forma nativa en Snowflake
    select 
        row_number() over (order by seq4()) - 1 as increment
    from table(generator(rowcount => 3653)) 
),

date_spine as (
    select 
        -- Sumamos el incremento a la fecha de inicio
        dateadd(day, increment, '1990-01-01'::date) as date_day
    from raw_generated_dates
)

select
    date_day as date_id,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(dayofweek from date_day) as day_of_week,
    case 
        when extract(dayofweek from date_day) in (0, 6) then true 
        else false 
    end as is_weekend
from date_spine