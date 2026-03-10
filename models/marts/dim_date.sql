{{ config(materialized='table') }}
-- Este modelo representa la dimensión de fechas, que se construye utilizando una técnica de "date spine" para generar un rango completo de fechas entre el 1 de enero de 1990 y el 1 de enero de 2000. Se extraen diferentes componentes de la fecha, como el año, mes, día y día de la semana, y se calcula si cada fecha es un fin de semana o no. Esta tabla se materializa como una tabla física en el almacén de datos para mejorar el rendimiento en las consultas que la utilicen.
with date_spine as (
    -- Generamos un rango de fechas usando una macro de dbt_utils
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('1990-01-01' as date)",
        end_date="cast('2000-01-01' as date)"
    ) }}
)
-- Seleccionamos las columnas relevantes para la dimensión de fechas, incluyendo el identificador de fecha, año, mes, día, día de la semana y si es fin de semana o no.
select
    date_day as date_id,
    extract(year from date_day) as year,
    extract(month from date_day) as month,
    extract(day from date_day) as day,
    extract(dayofweek from date_day) as day_of_week,
    case when extract(dayofweek from date_day) in (0, 6) then true else false end as is_weekend
from date_spine