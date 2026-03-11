# Reto Avanzado: Ingeniería y Gobernanza con dbt + Snowflake

## 1. Descripción del Proyecto
Este proyecto amplía el flujo ELT inicial para implementar funcionalidades avanzadas de **calidad de datos, trazabilidad histórica y orquestación**. El objetivo es garantizar un adecuado gobierno del dato y una observabilidad completa del pipeline de acuerdo a los requisitos de SDG Group.

## 2. Funcionalidades Avanzadas Implementadas

### A. Trazabilidad Histórica (Snapshots)
* **SCD Tipo 2**: Implementación de snapshots para la dimensión de clientes (`scd_customers`) para realizar un seguimiento de los cambios en dimensiones de variación lenta.
* **Propósito**: Mantener un historial de cambios que permita realizar análisis de un momento dado y comprender la evolución de los datos de clientes.

### B. Suite de Pruebas Personalizadas (Custom Tests)
Se han implementado pruebas SQL personalizadas para aplicar reglas de negocio específicas y requisitos de calidad:
* **Capa Staging**: Validación de rango de fechas para asegurar que los registros están dentro de un intervalo válido.
* **Capa Business**: Verificación de consistencia en importes de ventas para asegurar que los datos agregados coinciden con las expectativas.
* **Organización**: Las pruebas se han organizado en paquetes lógicos (Staging y Business) para mejorar el mantenimiento.

### C. Gobernanza y Documentación (Trazabilidad)
* **Cobertura**: Validación del nivel de documentación mediante el paquete `dbt-coverage`, garantizando un adecuado gobierno del dato[cite: 18, 19].
* **Linaje**: Documentación completa del grafo de dependencias y linaje de datos para asegurar la trazabilidad desde la fuente hasta el mart.

## 3. Estrategia de DevOps y Orquestación

### A. Gestión de Entornos y Ramas
Se sigue una estrategia de ramificación colaborativa profesional:
* **Flujo**: `feature/nueva_dimension` → `dev` → `main`.
* **Permisos**: Implementación de *post-hooks* para garantizar que, tras la destrucción y creación de tablas en ejecuciones `full-refresh`, todos los usuarios dispongan de los permisos necesarios.

### B. Orquestación y Observabilidad
Implementación de una estrategia de ejecución independiente por capas apoyada en **tags**:
* **Jobs en dbt Cloud**: Creación de jobs específicos para la carga y validación de cada etapa (Staging, Business).
* **Observabilidad**: Almacenamiento de trazas de ejecución para regular la orquestación y monitorizar la calidad del dato.

## 4. Instrucciones de Orquestación (Línea de Comandos)
Siguiendo los requisitos del proyecto, los jobs de dbt Cloud se invocan mediante línea de comandos para simular un orquestador externo:

1. **Validar Frescura de Fuentes**:
   ```bash
   dbt source freshness
   ```

2.  **Ejecutar Carga de Staging (Tags)**:
    ```bash
    dbt build --select tag:staging
    ```

3.  **Ejecutar Carga de Business/Marts (Tags)**:
    ```bash
    dbt build --select tag:business
    ```

---
**Desarrollado por:** Daniel Jiménez Aracil  