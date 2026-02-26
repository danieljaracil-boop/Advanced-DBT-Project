Welcome to your new dbt project!

# Reto Técnico: Arquitectura de Datos dbt + Snowflake

## Descripción
[cite_start]Implementación de un flujo ELT completo utilizando el dataset `TPCH_SF1`[cite: 2].

## Arquitectura de Capas
1. **Staging**: Mapeo directo de fuentes. [cite_start]`stg_orders` configurado como **incremental** para optimizar el rendimiento[cite: 4, 5, 6].
2. [cite_start]**Transformation**: Lógica intermedia para cálculos de negocio (Net Sales)[cite: 7, 8].
3. [cite_start]**Business**: Modelo dimensional (Star Schema) con `fct_sales` y dimensiones descriptivas.

## Calidad y Validación
Se implementaron tests de integridad (Unique, Not Null) y un test genérico personalizado para validar que no existan montos negativos en las ventas.

## Ejecución
1. Instalar dependencias: `dbt deps`
2. Ejecutar modelos: `dbt run`
3. Validar datos: `dbt test`