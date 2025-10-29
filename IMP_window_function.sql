create database tushar;
use tushar;
CREATE TABLE EmployeeSales (
    EmployeeID INT,
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2)
);


INSERT INTO EmployeeSales (EmployeeID, EmployeeName, Department, SaleDate, SaleAmount) VALUES
(1, 'Alice', 'Sales', '2025-06-01', 1200.00),
(1, 'Alice', 'Sales', '2025-06-03', 1800.00),
(1, 'Alice', 'Sales', '2025-06-07', 1500.00),
(2, 'Bob', 'Sales', '2025-06-01', 2000.00),
(2, 'Bob', 'Sales', '2025-06-05', 2200.00),
(2, 'Bob', 'Sales', '2025-06-08', 2100.00),
(3, 'Carol', 'Marketing', '2025-06-02', 3000.00),
(3, 'Carol', 'Marketing', '2025-06-06', 2800.00),
(3, 'Carol', 'Marketing', '2025-06-10', 2700.00),
(4, 'Dave', 'Marketing', '2025-06-01', 1000.00),
(4, 'Dave', 'Marketing', '2025-06-03', 1100.00),
(4, 'Dave', 'Marketing', '2025-06-09', 1300.00),
(5, 'Eve', 'HR', '2025-06-04', 900.00),
(5, 'Eve', 'HR', '2025-06-07', 950.00),
(5, 'Eve', 'HR', '2025-06-10', 1000.00),
(6, 'Frank', 'Sales', '2025-06-02', 1700.00),
(6, 'Frank', 'Sales', '2025-06-05', 1900.00),
(6, 'Frank', 'Sales', '2025-06-09', 1600.00),
(7, 'Grace', 'Finance', '2025-06-01', 2500.00),
(7, 'Grace', 'Finance', '2025-06-06', 2400.00),
(7, 'Grace', 'Finance', '2025-06-10', 2600.00),
(8, 'Hank', 'Finance', '2025-06-03', 2300.00),
(8, 'Hank', 'Finance', '2025-06-04', 2200.00),
(8, 'Hank', 'Finance', '2025-06-08', 2100.00),
(9, 'Ivy', 'HR', '2025-06-02', 800.00),
(9, 'Ivy', 'HR', '2025-06-06', 850.00),
(9, 'Ivy', 'HR', '2025-06-09', 950.00),
(10, 'Jake', 'IT', '2025-06-05', 3000.00),
(10, 'Jake', 'IT', '2025-06-07', 3200.00),
(10, 'Jake', 'IT', '2025-06-10', 3100.00);

select * from employeeSales; 
SELECT *, SUM(SaleAmount) OVER()
FROM EmployeeSales;

SELECT *, MAX(SaleAmount) OVER(PARTITION BY EmployeeName) FROM EmployeeSales

-- Running Sum and Cumulative Sum are the same thing in SQL window functions.

-- RUNNING SUM: SUM OF THE VALUES BASED ON THE DATA WHICH IS COMING. dONE BY USING ORDER BY
SELECT *, SUM(SaleAmount) OVER(ORDER BY SaleAmount) FROM EmployeeSales;
SELECT *, SUM(SaleAmount) OVER(ORDER BY SaleDate) FROM EmployeeSales;
SELECT *, SUM(SaleAmount) OVER(ORDER BY SaleDate DESC) FROM EmployeeSales;

-- RUNNING AVG
SELECT *, AVG(SaleAmount) OVER(ORDER BY SaleAmount) FROM EmployeeSales;

-- COMBINATION OF PARTITION BY AND ORDER BY
SELECT *, SUM(SaleAmount) OVER(PARTITION BY EmployeeName ORDER BY SaleAmount) FROM EmployeeSales;

-- department wise running sum/ cumulative sum
SELECT *, SUM(SaleAmount) OVER(PARTITION BY Department ORDER BY SaleAmount) FROM EmployeeSales;




create database window_test;

use window_test;

CREATE TABLE employee_sales (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    sale_amount DECIMAL(10,2),
    sale_date DATE
);

-- 2. Insert at least 20 sample records
INSERT INTO employee_sales (emp_name, department, sale_amount, sale_date) VALUES
('Alice', 'Electronics', 1200.00, '2025-01-10'),
('Bob', 'Electronics', 950.00, '2025-01-12'),
('Charlie', 'Furniture', 2100.00, '2025-01-15'),
('David', 'Furniture', 1800.00, '2025-01-18'),
('Ella', 'Clothing', 400.00, '2025-01-20'),
('Frank', 'Clothing', 750.00, '2025-01-22'),
('Grace', 'Clothing', 600.00, '2025-01-23'),
('Henry', 'Electronics', 1300.00, '2025-01-24'),
('Isabella', 'Furniture', 2500.00, '2025-01-25'),
('Jack', 'Clothing', 900.00, '2025-01-26'),
('Karen', 'Electronics', 1450.00, '2025-01-28'),
('Leo', 'Furniture', 1900.00, '2025-01-29'),
('Mona', 'Clothing', 500.00, '2025-01-30'),
('Nate', 'Electronics', 1600.00, '2025-02-01'),
('Olivia', 'Clothing', 800.00, '2025-02-02'),
('Peter', 'Furniture', 1700.00, '2025-02-03'),
('Quinn', 'Electronics', 1250.00, '2025-02-04'),
('Rose', 'Clothing', 1000.00, '2025-02-05'),
('Steve', 'Furniture', 2200.00, '2025-02-06'),
('Tina', 'Electronics', 1800.00, '2025-02-07');


select * from employee_sales;

SELECT *, SUM(Sale_Amount) OVER(PARTITION BY Department ) FROM Employee_Sales;
SELECT *, SUM(Sale_Amount) OVER(ORDER BY SaleAmount ) FROM EmployeeSales;
SELECT *, SUM(SaleAmount) OVER(PARTITION BY Department ORDER BY Sale_Amount ) FROM EmployeeSales;

SELECT *, SUM(Sale_Amount) OVER(PARTITION BY Department ORDER BY Sale_Amount),
row_number() OVER(PARTITION BY Department ) FROM Employee_Sales;

UPDATE employee_sales set sale_amount=500 WHERE emp_id =7;

-- RANK() → assigns ranks based on order, but if rows tie, they get the same rank and the next rank number is skipped.
-- DENSE_RANK() → assigns ranks based on order, and even if rows tie and share a rank, the next rank number is not skipped.
-- rank
SELECT *, row_number() OVER(PARTITION BY Department ),
rank() OVER(PARTITION BY Department ORDER BY Sale_Amount) FROM Employee_Sales;

-- DENSE RANK
SELECT *, row_number() OVER(PARTITION BY Department ),
dense_rank() OVER(PARTITION BY Department ORDER BY Sale_Amount) FROM Employee_Sales;

-- 2ND HIGHEST SALE
SELECT * FROM
(SELECT *, DENSE_RANK() OVER(ORDER BY sale_amount DESC) AS total_rank FROM employee_sales) AS abc
WHERE total_rank = 2;

SELECT * FROM(SELECT *, DENSE_RANK() OVER(ORDER BY sale_amount DESC) AS total_rank FROM employee_sales)
AS bcd WHERE total_rank = 3;

-- cte(COMMON TABLE EXPRESSION): name on temporary basic
-- cte is the temporary result of a query
-- cte can be used as a table
-- we can reuse it also as per our requirement
WITH abc AS
(SELECT *, DENSE_RANK() OVER(ORDER BY sale_amount DESC) AS total_rank FROM employee_sales)
SELECT * FROM abc WHERE total_rank = 2;

USE sakila;
SELECT * FROM actor;
SELECT * FROM film_actor;

-- SIMPLEST WAY TO OPTIMIZE YOUR JOINS
WITH film_cte AS(SELECT * FROM film_actor WHERE actor_id=1)
SELECT actor.actor_id, film_id FROM actor JOIN film_cte ON actor.actor_id = film_cte.actor_id;

-- SET OPERATIONS: USE TO COMBINE 2 OR MORE THAN 2 COLUMNS
-- RULE: NUMBER OF COLUMN SHOULD BE SAME, NAME OF COLUMN DOES NOT MATTER
-- | Operator           | What it does                                         |
-- | ------------------ | ---------------------------------------------------- |
-- | **UNION**          | Combines rows from both queries (removes duplicates) |
-- | **UNION ALL**      | Combines rows and keeps duplicates                   |
-- | **INTERSECT**      | Returns only common rows between queries             |
-- | **MINUS / EXCEPT** | Returns rows from 1st query that are not in 2nd      |

-- 1.UNION
SELECT actor_id, first_name, last_update FROM actor WHERE actor_id<=3
UNION
SELECT first_name, last_update, actor_id FROM actor WHERE actor_id between 3 and 6;

-- UNION ALL
SELECT actor_id, first_name, last_update FROM actor WHERE actor_id<=3
UNION ALL
SELECT first_name, last_update, actor_id FROM actor WHERE actor_id between 3 and 6;

-- recursive cte:
-- Recursive CTE = A CTE that calls itself repeatedly
-- Used to generate sequences or work with hierarchical data (parent-child)

-- lets try to create a series of numbers from 1 to 10
WITH cte AS(
SELECT 1 AS num)
SELECT * FROM cte;

-- try recursive now
WITH RECURSIVE cte AS (
    SELECT 1 AS num  -- base case
    UNION ALL
    SELECT num + 1 
    FROM cte 
    WHERE num < 10   -- end condition
)
SELECT * FROM cte;

