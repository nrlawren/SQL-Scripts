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
GROUP BY Customer_Name, Product_Name;

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

