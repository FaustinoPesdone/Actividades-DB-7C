## Ejercicio 6 - Materialized Views

Una **Materialized View** es parecida a una vista normal, pero con una diferencia importante: **guarda físicamente los resultados de la consulta**.

Una vista normal ejecuta la consulta cada vez que se la consulta, mientras que una materialized view guarda los datos obtenidos anteriormente.

### ¿Para qué se utilizan?

Se usan principalmente para mejorar el rendimiento cuando tenemos consultas muy pesadas, por ejemplo consultas con:

* Muchos `JOIN`.
* `GROUP BY`.
* Funciones como `SUM`, `AVG` o `COUNT`.
* Grandes cantidades de datos.

Por ejemplo, si tenemos una consulta que calcula las ventas totales de cada categoría y tarda mucho tiempo, se puede crear una materialized view con ese resultado y consultarla directamente.

### Diferencia con una View normal

Una vista normal:

```text
VIEW
↓
Ejecuta la consulta
↓
Obtiene los datos actuales
```

Una materialized view:

```text
MATERIALIZED VIEW
↓
Guarda el resultado
↓
Consulta los datos guardados
```

La ventaja de la materialized view es que suele ser más rápida.

La desventaja es que los datos pueden quedar desactualizados si las tablas originales cambian.

### Actualización de los datos

Por este motivo, las materialized views necesitan actualizarse o hacer un **refresh**.

Por ejemplo, en PostgreSQL:

```sql
REFRESH MATERIALIZED VIEW nombre_vista;
```

Esto vuelve a ejecutar la consulta y actualiza los datos almacenados.

### DBMS que las soportan

Algunos gestores de bases de datos que permiten usar Materialized Views son:

* **PostgreSQL**
* **Oracle Database**

Otros gestores tienen mecanismos parecidos. Por ejemplo, SQL Server utiliza las llamadas **Indexed Views**.

MySQL no tiene soporte directo para Materialized Views, pero se puede conseguir un resultado parecido creando una tabla y actualizándola mediante eventos, procedimientos o triggers.

### Alternativas

Si el DBMS no permite Materialized Views se pueden utilizar otras opciones como:

* Crear una tabla con los resultados de una consulta.
* Actualizar esa tabla cada cierto tiempo.
* Utilizar índices para mejorar el rendimiento.
* Utilizar caché.
* Utilizar procedimientos almacenados o eventos para mantener los datos actualizados.


Mi conclucion es que una Materialized View sirve para **guardar el resultado de una consulta compleja y poder acceder a ella más rápidamente**.

Su principal ventaja es mejorar el rendimiento, pero como los datos quedan almacenados, hay que actualizarlos cuando cambian las tablas originales.
