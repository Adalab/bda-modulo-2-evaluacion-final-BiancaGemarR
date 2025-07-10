USE sakila;
/*1.. Selecciona todos los nombres de las películas sin que aparezcan duplicados.*/
SELECT DISTINCT(title) /*Se usa distinct y así interpreta que no se debe repetir*/
FROM film;
/*2.. Muestra los nombres de todas las películas que tengan una clasificación de "PG-13".*/
SELECT title, rating
FROM film
WHERE rating = 'PG-13';
--QUERY final
SELECT title
FROM film
WHERE rating = 'PG-13';   
/*3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
descripción*/
SELECT title, description
FROM film
WHERE description LIKE '%amazing%';   /*Se usa un patrón que no afecte ni a lo que hay delante ni detrás*/

/*4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.*/
SELECT title, length
FROM film
WHERE length > 120;
--QUERY final
SELECT title
FROM film
WHERE length > 120;
/*5.Recupera los nombres de todos los actores.*/
SELECT first_name,
		last_name
FROM actor;
/*6.Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.*/
SELECT first_name,
		last_name
FROM actor
WHERE last_name = 'Gibson'; ---el apellido es Gibson
--OTRA opción, aunque creo que la primera es mejor
SELECT first_name,
		last_name
FROM actor
WHERE last_name IN ('Gibson');

/*7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.*/
SELECT first_name,
		last_name,
        actor_id
FROM actor
WHERE actor_id BETWEEN 10 AND 20; /*10 y 20 incluidos en la consulta*/

/*8.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
clasificación.*/
SELECT title,
		rating
FROM film
WHERE rating NOT IN ('R','PG-13'); 
--QUERY final sin comprobación
SELECT title
FROM film
WHERE rating NOT IN ('R','PG-13'); 
/*9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
clasificación junto con el recuento.*/ 
/*RATING es la clasificación*/
SELECT rating,
		COUNT(*) AS cantidad_total
FROM film
GROUP BY rating;
/*10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
nombre y apellido junto con la cantidad de películas alquiladas.*/
SELECT *
FROM rental;
--Query final
SELECT COUNT(rental.rental_id),
		customer.first_name,
        customer.last_name,
        customer.customer_id
FROM rental
INNER JOIN customer
ON rental.customer_id = customer.customer_id
GROUP BY customer.customer_id;

/*11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre 
de la categoría junto con el recuento de alquileres.*/

SELECT name 
FROM category;

SELECT *
FROM rental AS r
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
ON i.film_id = f.film_id
INNER JOIN film_category AS fa
ON f.film_id = fa.film_id
INNER JOIN category AS c
ON fa.category_id = c.category_id;

SELECT f.title,
		c.name,
        r.rental_id
FROM rental AS r
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
ON i.film_id = f.film_id
INNER JOIN film_category AS fa
ON f.film_id = fa.film_id
INNER JOIN category AS c
ON fa.category_id = c.category_id; 
--query final
SELECT c.name,
       COUNT(r.rental_id)
FROM rental AS r
INNER JOIN inventory AS i
ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
ON i.film_id = f.film_id
INNER JOIN film_category AS fa
ON f.film_id = fa.film_id
INNER JOIN category AS c
ON fa.category_id = c.category_id
GROUP BY c.name;

/*12.Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
muestra la clasificación junto con el promedio de duración.*/

SELECT AVG(length),
            rating
FROM film
GROUP BY rating;

/*13.Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".*/
SELECT title
FROM film
WHERE title = 'Indian Love';
--query final
SELECT a.first_name,
		a.last_name,
        f.title
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
LEFT JOIN film AS f
ON fa.film_id = f.film_id
WHERE title = 'Indian Love';

/*14.Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.*/
SELECT title, description
FROM film
WHERE description LIKE '%dog%' 
	OR description LIKE '%cat%';
--query final solo title
SELECT title
FROM film
WHERE description LIKE '%dog%' 
	OR description LIKE '%cat%';

/*15.Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor.*/
SELECT a.first_name,
		a.last_name
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;  /*EL resultado da que no hay ningún actor que no aparezca en la tabla film_actor*/

/*16.Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.*/
SELECT title, release_year
FROM film
WHERE release_year BETWEEN 2005 AND 2010;
/*Incluye 2005 y 2010, aunque en nuestra base de datos todas las películas sean del mismo año*/

/*17.Encuentra el título de todas las películas que son de la misma categoría que "Family".*/

SELECT f.title, c.name
FROM film AS f
LEFT JOIN film_category AS fca
ON f.film_id = fca.film_id
LEFT JOIN category AS c
ON fca.category_id = c.category_id
WHERE c.name = 'Family';
--En la query final quitamo el name
SELECT f.title AS título
FROM film AS f
LEFT JOIN film_category AS fca
ON f.film_id = fca.film_id
LEFT JOIN category AS c
ON fca.category_id = c.category_id
WHERE c.name = 'Family';

/*18.Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.*/

SELECT a.first_name AS nombre,
		a.last_name AS apellido,
        COUNT(f.film_id) AS recuento_peliculas
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
LEFT JOIN film AS f
ON fa.film_id = f.film_id
GROUP BY a.first_name, a.last_name
HAVING count(f.film_id) > 10;

/*19.Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
tabla film.*/
SELECT title AS título,
		rating,
        length
FROM film
WHERE rating = 'R' AND length > 120;
--QUERY final, solo queremos el 
SELECT title AS título
FROM film
WHERE rating = 'R' AND length > 120;

/*20.Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
muestra el nombre de la categoría junto con el promedio de duración.*/
SELECT c.name AS categoría,
		AVG(f.length) AS promedio_duración
FROM category AS c
LEFT JOIN film_category AS fca
ON c.category_id = fca.category_id
LEFT JOIN film AS f
ON fca.film_id = f.film_id
GROUP BY c.name
HAVING AVG(f.length) > 120;

/*21.Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
con la cantidad de películas en las que han actuado.*/
SELECT a.first_name AS nombre,
		a.last_name AS apellido,
        COUNT(fa.film_id) AS num_peliculas
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name;
--query final
SELECT a.first_name AS nombre,
		a.last_name AS apellido,
        COUNT(fa.film_id) AS num_peliculas
FROM actor AS a
LEFT JOIN film_actor AS fa
ON a.actor_id = fa.actor_id
GROUP BY a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 5;
 /*.22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
películas correspondientes.*/








