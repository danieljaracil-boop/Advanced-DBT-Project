{{ config(
    materialized='table'
) }}

-- Eliminamos 'static_analysis: strict' porque dbt ya lo aplica por defecto
-- pero falla con macros complejas como date_spine.

with date_spine as (

    {% if execute %}
        -- La lógica de date_spine solo se evalúa al ejecutar, 
        -- evitando que el analizador estático se bloquee intentando 'adivinar' el SQL.
        {{ dbt_utils.date_spine(
            datepart="day",
            start_date="cast('1990-01-01' as date)",
            end_date="cast('2000-01-01' as date)"
        ) }}
    {% else %}
        -- Esto es lo que ve el analizador estático para validar el modelo rápido.
        -- Proporcionamos un 'mock' de las columnas para que el resto del SQL compile.
        select cast('1990-01-01' as date) as date_day
    {% endif %}

)

select
    date_day as date_id,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(dayofweek from date_day) as day_of_week,
    case when extract(dayofweek from date_day) in (0, 6) then true else false end as is_weekend
from date_spine