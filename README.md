# Reto Técnico: Implementación de Arquitectura de Datos (dbt + Snowflake)

## 1. Descripción del Proyecto
[cite_start]Este proyecto consiste en la implementación de un flujo de datos completo (ELT) utilizando el dataset `TPCH_SF1` disponible en Snowflake[cite: 2, 11]. [cite_start]El objetivo principal es transformar datos crudos en una capa analítica compuesta por un modelo dimensional (Hechos y Dimensiones) explotable por las Business Units[cite: 2, 9].

## 2. Arquitectura de Capas
[cite_start]Se ha diseñado una arquitectura modular dividida en tres capas de modelización[cite: 3]:

### A. Staging Layer (Extracción)
[cite_start]Su propósito es ejecutar la extracción de datos desde los sistemas fuente con el menor impacto posible en el desempeño[cite: 4].
* [cite_start]**Entidades**: Contiene las mismas entidades que el dataset origen[cite: 5].
* **Estrategia de Carga**: 
    * [cite_start]`stg_orders`: Configurada con carga **incremental** para optimizar ventanas de tiempo[cite: 5].
    * [cite_start]Resto de entidades: Configuración de carga total[cite: 5].
* [cite_start]**Materialización**: Tablas[cite: 6].

### B. Transformation Layer (Intermedia)
[cite_start]Capa donde se llevan a cabo transformaciones y combinaciones parciales (campos calculados, granularidad y joins)[cite: 7].
* [cite_start]**Materialización**: Vista (carga total)[cite: 8].
* **Innovación**: Uso de una **Macro personalizada** (`calculate_discounted_amount`) para estandarizar cálculos financieros de forma reutilizable.

### C. Business Layer (Consumo)
[cite_start]Capa final que proporciona el modelo dimensional explotable[cite: 9].
* [cite_start]**Modelo**: Esquema en estrella (Star Schema)[cite: 2].
* [cite_start]**Entidades**: Tabla de hechos `fct_sales` y dimensiones descriptivas `dim_customers` y `dim_date`[cite: 2].
* [cite_start]**Materialización**: Tabla (carga total)[cite: 10].



## 3. Calidad y Gobernanza de Datos
Para garantizar un modelo confiable y de nivel profesional, se han implementado:
* **Tests Genéricos**: Pruebas de `unique` y `not_null` en todas las claves primarias.
* **Integridad Referencial**: Tests de `relationships` para asegurar la consistencia entre hechos y dimensiones.
* **Tests de Negocio**: Validación personalizada (`test_no_negative_values`) para asegurar que no existan montos de venta negativos.
* [cite_start]**Monitoreo (Freshness)**: Control de frescura en el origen para garantizar que los datos se actualizan según los SLAs pactados[cite: 4].

## 4. Stack Tecnológico
* [cite_start]**Base de Datos**: Snowflake[cite: 11].
* [cite_start]**Transformación (ETL)**: dbt (Data Build Tool)[cite: 11].
* **Lenguaje**: SQL + Jinja (Macros).
* **Control de Versiones**: Git.

## 5. Instrucciones de Ejecución
1. **Instalar Dependencias**: 
   ```bash
   dbt deps 
   ````

2. **Construir y validar el proyecto**
   ````bash
   dbt build
   ````

3. **Generar documentación y linage**:
   ````bash
   dbt docs generate
   dbt docs serve
   ````





