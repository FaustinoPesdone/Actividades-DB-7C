## Ejercicio 5 - Análisis de la vista `actor_info`

La vista muestra la información de cada actor y las películas en las que participó separadas por categoría .

### Consulta

```sql
CREATE VIEW actor_info AS
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    GROUP_CONCAT(
        DISTINCT CONCAT(
            c.name, ': ',
            (
                SELECT GROUP_CONCAT(f2.title SEPARATOR ', ')
                FROM film f2
                JOIN film_category fc2
                    ON f2.film_id = fc2.film_id
                JOIN film_actor fa2
                    ON f2.film_id = fa2.film_id
                WHERE fc2.category_id = c.category_id
                AND fa2.actor_id = a.actor_id
            )
        )
        SEPARATOR '; '
    ) AS film_info
FROM actor a
LEFT JOIN film_actor fa
    ON a.actor_id = fa.actor_id
LEFT JOIN film_category fc
    ON fa.film_id = fc.film_id
LEFT JOIN category c
    ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;
```

### Explicación

La consulta principal comienza desde la tabla `actor` y mediante los `JOIN` con `film_actor`, `film_category` y `category` obtiene las categorías de las películas en las que participó cada actor.

El `GROUP BY`:

```sql
GROUP BY a.actor_id, a.first_name, a.last_name
```

hace que el resultado final tenga una sola fila por actor.

La parte más importante de la subconsulta es esta :

```sql
SELECT GROUP_CONCAT(f2.title SEPARATOR ', ')
FROM film f2
JOIN film_category fc2
    ON f2.film_id = fc2.film_id
JOIN film_actor fa2
    ON f2.film_id = fa2.film_id
WHERE fc2.category_id = c.category_id
AND fa2.actor_id = a.actor_id
```

Esta subconsulta busca todas las películas del actor que se está procesando y que además pertenezcan a la categoría actual.

Es una **subconsulta correlacionada** porque utiliza valores de la consulta principal osea del exterior:

```sql
c.category_id
a.actor_id
```

Por ejemplo, si actualmente se está procesando un actor dentro de la categoría `Comedy`, la subconsulta busca únicamente las películas de ese actor que sean de esa categoría.

El `GROUP_CONCAT` de la subconsulta junta los títulos:

```text
Film A, Film B, Film C
```

Después el `CONCAT` agrega el nombre de la categoría:

```text
Comedy: Film A, Film B, Film C
```

Por último, el `GROUP_CONCAT` externo junta todas las categorías del actor:

```text
Action: Film A, Film B; Comedy: Film C, Film D
```

