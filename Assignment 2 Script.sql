-- Assignment 2 Script
-- Nash Lawrence 2/24/22

-- 4.) Add at least five new business rules
-- A staff member can accept multiple payments
-- A store can have one to many customers
-- A store can have one to many inventory items
-- One address can have one to many staff members
-- A customer can make one to many patments

-- a.) Tell SQL to use sakila schema
USE sakila;

-- b.) Create SQL program to get aggregate count of the number of films
SELECT count(film_id) AS 'NumberFilms'
FROM film;

-- c.) Create SQL program to know the count of films involving Nick Wahlberg
SELECT count(film_id) AS 'WahlbergFilms' FROM film_actor, actor
WHERE film_actor.actor_id = actor.actor_id
AND first_name = 'NICK'
AND last_name = 'WAHLBERG';

-- d.) Write program listing films having a PG rating
SELECT film.title AS 'PGMovies'
FROM film
WHERE film.rating = "PG";

-- e.) Create program to extract total amount of revenue received per store manager
SELECT manager_staff_id AS 'Manager', sum(amount) AS 'TotalRevenue'
FROM store, payment
WHERE store.manager_staff_id = payment.staff_id
GROUP BY manager_staff_id;

-- f.) Write SQL program to display average revenue grouped by store. Format results to 2 decimals and sort them by average revenue descending order
SELECT store.store_id, round(AVG(amount), 2) AS 'AverageRevenue'
FROM store, staff, payment
WHERE store.store_id = staff.staff_id
AND staff.staff_id = payment.staff_id
GROUP BY store.store_id
ORDER BY 'AverageRevenue' DESC;

-- g.) Create program to extract and group the total counts of films by rating and sorts the results in descending order by film count
SELECT film.rating, count(*) AS FilmCount
FROM film
GROUP BY film.rating
ORDER BY FilmCount DESC;

-- h.) Display the count of all films grouped by rating using a inner query
SELECT film.rating, count(*) AS 'FilmCount',
	(SELECT COUNT(*) FROM film) AS 'TotalCount'
FROM film
GROUP BY rating;

-- i.) Create a program selecting all films starting with letter 'a' and a fourth letter 'd'
SELECT title FROM film
WHERE film.title LIKE 'a__d%';

-- j.) Use regular expression with [] symbol to display film titles with a k or q in them
SELECT title FROM film
WHERE film.title REGEXP '[kq]';

-- k.) Use the sample solution to write a query showing overdue film rentals
SELECT CONCAT(customer.last_name, ', ', customer.first_name) AS customer,
			address.phone, film.title, rental_date, film.rental_duration, current_date(),
            datediff(current_date(), rental_date + INTERVAL film.rental_duration DAY) AS DaysOverdue
            FROM rental INNER JOIN customer ON rental.customer_id = customer.customer_id
            INNER JOIN address ON customer.address_id = address.address_id
            INNER JOIN inventory ON rental.inventory_id = inventory.inventory_id
            INNER JOIN film ON inventory.film_id = film.film_id
            WHERE rental.return_date IS NULL
            AND rental_date + INTERVAL film.rental_duration DAY < CURRENT_DATE()
            ORDER BY title
            LIMIT 5;

-- L.) Create SQL program using GROUP BY to show customers who owe more than $200 with ROLLUP
SELECT IF(GROUPING(payment.customer_id), "TotalOwed", customer_id) AS "CustomerID", SUM(payment.amount) AS MoneyOwed
FROM payment
GROUP BY customer_id
WITH ROLLUP
HAVING MoneyOwed > 200
ORDER BY MoneyOwed DESC;

/* m.) Create SQL program using PARTITION to show payment amounts by rentals partitioned over customer
	   For each rental include customer first name, last name, payment amount and payment date
       Show Total Payment Amount as partitioned column */
SELECT customer.customer_id, first_name, last_name,
SUM(amount) OVER(PARTITION BY customer_id) AS 'TotalPayment', payment_date
FROM customer, rental, payment
WHERE rental.customer_id = customer.customer_id
AND rental.customer_id = payment.customer_id;
