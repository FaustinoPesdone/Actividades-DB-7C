USE sakila;

#EJERCICIO 1

CREATE VIEW list_of_customers AS 
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS Nombre_completo,
	   a.address, a.postal_code, a.phone, ci.city, co.country,
	   CASE 
	   	WHEN c.active = 1 THEN 'active'
	   	ELSE 'inactive'
	   END AS status
	   , c.store_id
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN country co ON ci.country_id = co.country_id;


SELECT *
FROM list_of_customers;	 

#EJERCICIO 2

CREATE VIEW film_details AS 
SELECT f.film_id, f.title, f.description, c.name AS category,
	   f.rental_rate AS price,
	   f.length, f.rating, 
	   GROUP_CONCAT(CONCAT(a.firt_name,' ',a.last_name)
	   									SEPARATOR ', ') AS actores
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id
GROUP BY
    f.film_id,
    f.title,
    f.description,
    c.name,
    f.rental_rate,
    f.length,
    f.rating;

SELECT *
FROM film_details;

#EJERCICIO 3 

CREATE VIEW sales_by_film_category4 AS
SELECT c.name AS category, SUM(p.amount) AS total_rental
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
GROUP BY c.name;

SELECT *
FROM sales_by_film_category4;

#EJERCICIO 4

CREATE VIEW actor_information AS 
SELECT a.actor_id, CONCAT(a.first_name, ' ',a.last_name),
	   COUNT(fa.film_id) AS cantidad_de_canciones
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY  a.actor_id,a.first_name,a.last_name;

SELECT *
FROM actor_information;

#EJERCICIO 5

SELECT *
FROM actor_info;

#El analisis lo hice en el Repo






