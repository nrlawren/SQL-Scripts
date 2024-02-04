-- Lab 5 Script
-- Nash Lawrence

USE sale;

-- Exercise 1: Aggregate sales quantity
SELECT Customer_Name, CustomerID, sum(Quantity) AS 'TotalQuantity'
FROM sale.order, customer
WHERE sale.order.CustomerID = customer.Customer_ID
GROUP BY sale.order.CustomerID
ORDER BY totalQuantity DESC;

-- Exercise 2: Show the names of products with the most sales descending order
SELECT Customer_Name, Product_Name, SUM(sale.order.Quantity) AS 'TotalSales'
FROM sale.order, customer, product
WHERE product.Product_ID = sale.order.ProductID
AND customer.Customer_ID = sale.order.CustomerID
AND customer.Customer_State = "VA"
GROUP BY Customer_Name, Product_Name
ORDER BY TotalSales DESC;

SELECT Customer_Name FROM customer;

-- Exercise 3: Who is the best customer in revenue
SELECT Customer_Name, SUM(UnitPrice * Quantity) AS TotalSales
FROM sale.order, customer
WHERE sale.order.CustomerID = customer.Customer_ID
GROUP BY sale.order.CustomerID
ORDER BY TotalSales DESC;

-- Exercise 4: Alphabetically list all of the customer state codes and aggregate by total sales
SELECT Customer_State,  SUM(UnitPrice * Quantity) AS TotalSales
FROM sale.order, customer
WHERE sale.order.CustomerID = customer.Customer_ID
GROUP BY Customer_State
ORDER BY Customer_State DESC;

-- Exercise 5: Create a view for order quantity totals by customer
CREATE VIEW QuantityTotalbyCustomer AS
	SELECT customer.Customer_ID, SUM(Quantity) AS Total
    FROM sale.order, customer
    WHERE sale.order.CustomerID = customer.Customer_ID
    GROUP BY sale.order.CustomerID
    ORDER BY Total;

-- Use the view
SELECT * FROM QuantityTotalbyCustomer;


-- Recursion Example 3/23 Ch.5
USE sale;

-- Create an employees table with employees and managers (who are also employees)
CREATE TABLE employees (
 id			INT PRIMARY KEY NOT NULL,
 name		VARCHAR(100) NOT NULL,
 manager_id INT NULL,
 INDEX (manager_id),
FOREIGN KEY (manager_id) REFERENCES employees (id)
);

-- Populate the table with data
INSERT INTO employees VALUES
(333, "Yasmina", NULL),
(198, "John", 333),
(692, "Tarek", 333),
(29, "Pedro", 198),
(4610, "Sarah", 29),
(72, "Pierre", 29),
(123, "Adil", 692);

-- show table results
SELECT * FROM employees ORDER BY id;

-- Create the org chart path
WITH RECURSIVE employee_paths (id, name, path) AS
(
  SELECT id, name, CAST(id AS CHAR(200))
    FROM employees
    WHERE manager_id IS NULL
  UNION ALL
  SELECT e.id, e.name, CONCAT(ep.path, ',', e.id)
    FROM employee_paths AS ep JOIN employees AS e
      ON ep.id = e.manager_id
)
SELECT * FROM employee_paths ORDER BY path;


