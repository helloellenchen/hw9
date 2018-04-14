SELECT first_name, last_name FROM sakila.actor;
USE sakila;
SELECT first_name, last_name 
FROM actor;
SELECT concat(first_name, ' ',last_name) as Actor_Name
FROM actor;
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'JOE';
select * from actor where first_name = 'Joe';
SELECT actor_id, first_name, last_name 
FROM actor
WHERE first_name = 'JOE';
select * from actor where last_name like'%GEN%';
select actor_id, first_name, last_name 
FROM actor where last_name like'%LI%' order by last_name, first_name;
SELECT country_id,  country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

SELECT * FROM actor;
alter table actor
add column middle_name varchar(50) after first_name;

-- 3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
SELECT * FROM actor;

ALTER TABLE actor
ADD COLUMN  middle_name VARCHAR(50) AFTER first_name;


-- 3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
ALTER TABLE actor 
MODIFY COLUMN middle_name BLOB;
-- 3c. Now delete the middle_name column.
ALTER TABLE actor
DROP COLUMN middle_name;

-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, COUNT(*) AS 'count' from actor group by 'last_name';
SELECT last_name, COUNT(*) AS 'Count'
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(*) AS `Count`
FROM actor
GROUP BY last_name
HAVING `Count` > 2;
-- 4c
update actor
set first_name = 'GROUCHO'
where last_name = 'williams' and first_name = 'HARPO';

-- 4c.1
UPDATE actor 
SET first_name= 'GROUCHO'
WHERE first_name='HARPO' AND last_name='WILLIAMS';

-- 5a
DESCRIBE sakila.address;
-- 6a  Use the tables staff and address:
use sakila ;
SELECT staff.first_name, staff.last_name, address.address
FROM staff  LEFT JOIN address ON staff.address_id = address.address_id;

-- 6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
SELECT s.first_name, s.last_name, SUM(p.amount) AS 'TOTAL'
FROM staff s LEFT JOIN payment p  ON s.staff_id = p.staff_id
GROUP BY s.first_name, s.last_name;

-- 6c. List each film and the number of actors who are listed for that film

select film_actor, count(film_actor.actor_id) as 'total'
FROM sakila.film f left join film_actor a on f.film_id = a.film_id
Group by f.title;

-- 6d.
select count(f.title)
FROM sakila.film f left join film_actor a on f.film_id = a.film_id
where f.title = 'Hunchback Impossible';

-- 6e list the total paid by each customer
select customer.first_name, customer.last_name, sum(payment.amount) as 'total'
from customer c left join payment p on c.customer_id = p.customer_id 
group by c.first_name, c.last_name
order by c.last_name;

-- 7a
SELECT f.title
FROM sakila.film f
WHERE (f.title LIKE 'K%' OR f.title like'Q%')
AND language_id=(SELECT language_id FROM language where name='English');


-- 7b. Use subqueries to display all actors who appear in the film Alone Trip.
SELECT first_name, last_name
FROM actor
WHERE actor_id
	IN (SELECT actor_id FROM film_actor WHERE film_id 
		IN (SELECT film_id from film where title='ALONE TRIP')); 
-- 7c
SELECT first_name, last_name, email 
FROM customer cu
Join address a on (cu.address_id = a.address_id)
join city cit on (a.city_id = cit.city_id)
join country cntry on (cit.country_id = cntry.country_id);

-- 7d Identify all movies categorized as famiy films.
SELECT title, film_id from film f

JOIN film_category fcat on (f.film_id=fcat.film_id)
JOIN category c on (fcat.category_id=c.category_id)
where category.name = 'family';

-- 7e 
SELECT title, COUNT(f.film_id) AS 'Count_of_Rented_Movies'
FROM  film f
JOIN inventory i ON (f.film_id= i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
GROUP BY title ORDER BY Count_of_Rented_Movies DESC;

-- 7f Write a query to display how much business, in dollars, each store brought in
SELECT s.store_id, SUM(p.amount) 
FROM payment p
JOIN staff s ON (p.staff_id=s.staff_id)
GROUP BY store_id;


-- 7g. Write a query to display for each store its store ID, city, and country.
SELECT store_id, city, country FROM store s
JOIN address a ON (s.address_id=a.address_id)
JOIN city c ON (a.city_id=c.city_id)
JOIN country cntry ON (c.country_id=cntry.country_id);

-- 7h List the top five genres in gross revenue in descending order. 
SELECT c.name AS 'Top Five' , SUM(p.amount) AS 'gross'
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- 8a
SELECT c.name AS "Top Five", SUM(p.amount) AS "Gross" 
FROM category c
JOIN film_category fc ON (c.category_id=fc.category_id)
JOIN inventory i ON (fc.film_id=i.film_id)
JOIN rental r ON (i.inventory_id=r.inventory_id)
JOIN payment p ON (r.rental_id=p.rental_id)
GROUP BY c.name ORDER BY Gross  LIMIT 5;

-- 8b. How would you display the view that you created in 8a?
SELECT* FROM TopFive


























