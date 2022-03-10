USE sakila;

-- how many customers does the company have
SELECT count(customer_id) FROM customer;

-- select customers with last name starting with 'a'
SELECT last_name
FROM customer
WHERE last_name LIKE 'a%';

-- customers with last name starting with 'a' and 7 character length
SELECT last_name
FROM customer
WHERE last_name LIKE 'a______%';

-- customers with last name starting with 'a' and the thrid letter 't'
SELECT last_name
FROM customer
WHERE last_name LIKE 'a_t%';

-- Select all cities that start with 'a' 'b' or 'c'
-- ^ means 'Begins with' in REGEXP
SELECT * FROM city
WHERE city REGEXP '^(A|B|C)';

-- Select all last names ending in 'on'
SELECT last_name
FROM customer
WHERE last_name REGEXP 'on$';

-- Select customer last names with 'x' or 'z' in it
SELECT last_name FROM customer
WHERE last_name REGEXP '[xz]';

-- Select customer last names that do not have 'x' or 'z' in it
SELECT last_name
FROM customer
WHERE last_name NOT REGEXP '[XZ]';

-- Produce a message based on the movie price
SELECT customer_id, rental_id, amount,
IF (amount > 5, "The amount is greater than 5", "The amount is 5 or under") AS Message
FROM payment;

-- Use a Case structure to produce a message
SELECT customer_id, rental_id, amount,
CASE
	WHEN amount > 5 THEN "The amount is greater than 5"
    WHEN amount = 5 THEN "The amount is 5"
    ELSE "The amount is under 5"
END AS Message
FROM payment;

-- List aggregated sums of payment amounts based on customer ID
SELECT customer_id, SUM(amount) AS TotalAmount
FROM payment
GROUP BY customer_id
ORDER BY TotalAmount DESC;

-- List only amounts greater than 100
SELECT customer_id, SUM(amount) AS TotalAmount
FROM payment
GROUP BY customer_id
HAVING TotalAmount > 100
ORDER BY TotalAmount DESC;

-- Remove HAVING statement and Add a ROLLUP to the GROUP BY statement from question above
SELECT customer_id, SUM(amount) AS TotalAmount
FROM payment
GROUP BY customer_id
WITH ROLLUP
ORDER BY TotalAmount DESC;

-- Partition rows of payment table into groups
SELECT payment_id, last_name AS Customer, staff_id, rental_id, payment_date, SUM(amount)
OVER (Partition BY staff_id) AS 'TotalByStaffID'
FROM payment AS p, customer AS c
WHERE p.customer_id = c.customer_id
ORDER BY customer;

