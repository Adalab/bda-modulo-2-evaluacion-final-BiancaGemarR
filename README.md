-Descripción del proyecto
Un cliente ha encargado, a través de la base de datos Sakila, hacer unas consultas relacionadas con las diversas
partes de la gestión de un VideoClub.
-Cómo pueden usarlo los usuarios?
Simplemente, pueden leer lo que se busca y allí encontraran una consulta. Si esta es seleccionada, saldrá la respuesta y se podrán interpretar.
Por Ejemplo:

#4.Si quieres ver una película larga de más de 120 minutos. 
SELECT title
FROM film
WHERE length > 120;

O bien, otro ejemplo:

#18.Muestra el nombre y apellido de los actores que aparecen en más de 10 películas.
Si quieres ver una película de alguien con una larga trayectoria.

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

-El script de SQL puede servir de referencia a alguien que se quiera iniciar con Querys básicas.
Autora de este script:
Bianca Gemar Rosado