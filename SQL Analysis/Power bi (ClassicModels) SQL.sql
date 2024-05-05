USE `classicmodels`;

# Q1. Total sales and the number of orders for each year from 2003 until 2005 where the order status is Shipped.

select year(orderDate) as year, count(orderNumber) as Num_orders, sum(priceeach * quantityordered) as Sales
from orders
join orderdetails using(orderNumber)
where status = 'Shipped' and year(orderDate) between 2003 and 2005
group by year(orderDate);

# Q2. Total Sales by Status.

SELECT status, SUM(priceeach * quantityordered) AS TotalSales
FROM orders
JOIN orderdetails USING (ordernumber)
WHERE status IN ('Shipped', 'Resolved', 'Disputed')
GROUP BY status;


# Q3. Repeat customers?

SELECT COUNT(DISTINCT customerNumber) AS RepeatCustomersCount
FROM orders
WHERE customerNumber IN (
    SELECT customerNumber
    FROM orders
    GROUP BY customerNumber
    HAVING COUNT(*) > 1
);


# Q4. Year wise total sales
 
SELECT YEAR(o.orderDate) AS Year, SUM(od.quantityOrdered * od.priceEach) AS TotalSales
FROM orderDetails od
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY EAR(o.orderDate);


-# Q5. ProductLine Wise Revenue

SELECT productline, SUM(priceEach*QuantityOrdered) as Revenue
FROM orders 
JOIN orderdetails USING(orderNumber)
JOIN products USING(productCode) 
JOIN productlines USING(productline)
WHERE status IN ("Shipped","Resolved","Disputed")
GROUP BY productline
ORDER BY Revenue DESC;


# Q6. -- Year Wise cost,sales,profit, Qty Sold
SELECT 
	YEAR(orderDate) as Year,
    SUM(QuantityOrdered*buyPrice) as Cost,
	SUM(priceEach*QuantityOrdered) as sales,
	SUM(QuantityOrdered*(priceEach-buyPrice)) as Profit,
    SUM(QuantityOrdered) as qty
FROM 
	orderdetails JOIN orders USING(orderNumber)
    JOIN products USING(productCode)
WHERE status IN ("Shipped","Resolved","Disputed")
GROUP BY year;

