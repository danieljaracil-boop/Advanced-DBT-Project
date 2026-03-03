{{ config(materialized='table') }}

with date_spine as (
    -- Generamos un rango de fechas usando una macro de dbt_utils
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1990-01-01' as date)",
        end_date="cast('2000-01-01' as date)"
    ) }}  
    
    -- Esta macro generará una tabla con una columna llamada date_day 
    -- que contiene todas las fechas entre el 1 de enero de 1990 y el 1 de enero de 2000
)

select
    date_day as date_id,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(dayofweek from date_day) as day_of_week,
    case when extract(dayofweek from date_day) in (0, 6) then true else false end as is_weekend
from date_spine