CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    salary DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO users (name, email, gender, date_of_birth, salary) VALUES
('Aarav', 'aarav@example.com', 'Male', '1995-05-14', 65000.00),
('Ananya', 'ananya@example.com', 'Female', '1990-11-23', 72000.00),
('Raj', 'raj@example.com', 'Male', '1988-02-17', 58000.00),
('Sneha', 'sneha@example.com', 'Female', '2000-08-09', 50000.00),
('Farhan', 'farhan@example.com', 'Male', '1993-12-30', 61000.00),
('Priyanka', 'priyanka@example.com', 'Female', '1985-07-12', 84000.00),
('Aisha', 'aisha@example.com', 'Female', '1997-03-25', 56000.00),
('Aditya', 'aditya@example.com', 'Male', '1992-06-17', 69000.00),
('Meera', 'meera@example.com', 'Female', '1989-09-05', 77000.00),
('Ishaan', 'ishaan@example.com', 'Male', '2001-10-02', 45000.00),
('Tanvi', 'tanvi@example.com', 'Female', '1994-04-18', 62000.00),
('Rohan', 'rohan@example.com', 'Male', '1986-12-01', 75000.00),
('Zoya', 'zoya@example.com', 'Female', '1998-01-15', 54000.00),
('Karan', 'karan@example.com', 'Male', '1990-08-22', 68000.00),
('Nikita', 'nikita@example.com', 'Female', '1987-03-10', 71000.00),
('Manav', 'manav@example.com', 'Male', '1996-11-29', 61000.00),
('Divya', 'divya@example.com', 'Female', '1991-02-28', 57000.00),
('Harshit', 'harshit@example.com', 'Male', '1993-09-09', 65000.00),
('Ritika', 'ritika@example.com', 'Female', '1999-05-05', 52000.00),
('Imran', 'imran@example.com', 'Male', '1995-07-30', 63000.00),
('Juhi', 'juhi@example.com', 'Female', '1992-10-14', 59000.00),
('Tushar', 'tushar@example.com', 'Male', '1990-01-08', 73000.00),
('Lata', 'lata@example.com', 'Female', '1984-11-11', 78000.00),
('Yash', 'yash@example.com', 'Male', '1997-06-06', 64000.00),
('Fatima', 'fatima@example.com', 'Female', '1993-03-03', 55000.00);





USE startersql;
-- Querying Data in MySQL using SELECT
-- The SELECT statement is used to query data from a table.

-- To select all columns:
SELECT * FROM users;

-- To select multiple columns:
SELECT gender, name FROM users;
SELECT name, gender FROM users;

-- Filtering Rows with WHERE
-- Filtering all rows from column gender where gender is female
SELECT * from users WHERE gender="Female";

-- Filtering all rows from column gender where gender is male
SELECT * from users WHERE gender="Male";

-- Filtering names and gender from column gender where gender is male
SELECT name, gender from users WHERE gender="Male";
SELECT name, gender from users WHERE gender<>"Female";
SELECT name, gender from users WHERE gender!="Female";

-- Filtering names and gender from column gender where gender is female
SELECT name, gender from users WHERE gender="Female";
SELECT name, gender from users WHERE gender<>"Male";
SELECT name, gender from users WHERE gender!="Male";

-- selecting users from table users where date of birth is less than or greater than a certain date
select * from users WHERE date_of_birth < "1999-01-23";
select * from users WHERE ID>10;

-- Filtering Rows with WHERE
-- Equal To
SELECT * from users WHERE gender="Male";

-- Not Equal To
SELECT * FROM users WHERE gender != 'Female';
SELECT * FROM users WHERE gender <> 'Female';

-- Greater Than / Less Than
SELECT * FROM users WHERE date_of_birth < '1995-01-01';
SELECT * FROM users WHERE id > 10;

-- Greater Than or Equal / Less Than or Equal
SELECT * from users WHERE id>=5;
SELECT *from users WHERE id<=5;


-- Working with NULL

-- to filter null entries from a column
-- SELECT * from users WHERE date_of_birth = NULL;(it will filter data which is equals to a certain value)

-- IS NULL
SELECT * from users WHERE date_of_birth IS NULL;

-- IS NOT NULL
SELECT * from users WHERE date_of_birth IS NOT NULL;

-- BETWEEN
SELECT * from users WHERE date_of_birth BETWEEN "1993-01-23" AND "1999-01-23";

-- IN
SELECT * from users WHERE gender in ("Male","Female");
SELECT * from users WHERE gender in ("Other");
SELECT * from users WHERE gender in ("Male");


-- AND / OR
SELECT * FROM users WHERE gender = 'Female' AND date_of_birth > '1990-01-01';

SELECT * FROM users WHERE gender = 'Male' OR gender = 'Other';

SELECT * FROM users WHERE gender = "Male" AND salary>70000;

SELECT * FROM users WHERE gender = "Female" or salary>74000;


-- ORDER BY(lexical (lexicographical order))
SELECT * from users ORDER BY date_of_birth ASC; 
SELECT * from users ORDER BY name DESC;
SELECT * from users WHERE gender="Male" and salary> 65000; -- by default, ordered by id
SELECT * from users WHERE gender="Male" and salary>65000 ORDER BY date_of_birth ASC; -- (ordered by data of birth now in ascending order)
SELECT * from users WHERE gender="Male" and salary>65000 ORDER BY date_of_birth DESC; -- (ordered by data of birth now in descending order)

-- LIMIT
SELECT * from users LIMIT 5;    -- -- Top 5 rows
SELECT * from users LIMIT 5 OFFSET 10; -- -- Skip first 5 rows, then get next 10
SELECT * from users LIMIT 10 OFFSET 5; -- -- Get 10 rows starting from the 6th row (Same as above)
SELECT * from users LIMIT 5,10;       -- (SAME AS ABOVE)



-- UPDATE - Modifying Existing Data
-- The UPDATE statement is used to change values in one or more rows.
-- Query is a single instruction however Script is a collection of instruction

-- Basic Syntax:
UPDATE table_name
SET column1 = value1, column2 = value2
WHERE condition;

-- Example: Update One Column
UPDATE users SET name="Shabaul" WHERE id=1;
-- This changes the name of the user with id = 1 to Shabaul
SELECT * from users;

-- Example: Update Multiple Columns
UPDATE users SET name="Shabaul Haque",email="shabaul2025@gmail.com",date_of_birth="1999-01-23",gender="Male" WHERE id=2;

-- Without WHERE Clause (Warning)
-- UPDATE users SET gender = 'Other';
-- This updates every row in the table. Be very careful when omitting the WHERE clause.

-- Q.1  Update the salary of user with id = 5 to ₹70,000.
UPDATE users SET salary=70000 where id=5;
select * from users WHERE id=5;


-- Q.2  Change the name of the user with email aisha@example.com to Aisha Khan.
UPDATE users SET name="Aisha Khan" WHERE email="aisha@example.com";
SELECT * from users WHERE email="aisha@example.com";

-- Q.3  Increase salary by ₹10,000 for all users whose salary is less than ₹60,000.
SET SQL_SAFE_UPDATES = 0;
UPDATE users SET salary=salary+10000 WHERE salary<60000;
SELECT * from users WHERE salary>60000;
-- SET SQL_SAFE_UPDATES = 1; -- If you don’t turn SQL_SAFE_UPDATES back on, MySQL will stay in unsafe update mode for your session (or until you reconnect).

-- Q.4 Set the gender of user Ishaan to Other.
UPDATE users SET gender="Other" WHERE name="Ishaan";
SELECT * from users WHERE name="Ishaan";

-- Q.5 Reset salary of all users to ₹50,000 (Careful - affects all rows).
UPDATE users SET salary=50000;
SELECT * from users;


-- DELETE - Removing Data from a Table
-- The DELETE statement removes rows from a table.
-- Basic Syntax:
DELETE FROM table_name WHERE condition;
DELETE from users WHERE id=3;
SELECT * from users;

-- Example: Delete One Row
DELETE FROM users WHERE id = 3;

-- Delete Multiple Rows
DELETE FROM users WHERE gender = 'Other';

-- Delete All Rows (but keep table structure)
-- DELETE FROM users;

-- Drop the Entire Table (use with caution)
-- DROP TABLE users;
-- This removes the table structure and all data permanently.


-- Best Practices
-- Always use WHERE unless you're intentionally updating/deleting everything.
-- Consider running a SELECT with the same WHERE clause first to confirm what will be affected:
-- SELECT * FROM users WHERE id = 3;
-- Always back up important data before performing destructive operations.


-- MySQL Constraints:
-- Constraints in MySQL are rules applied to table columns to ensure the accuracy,
-- validity, and integrity of the data.

-- 1. UNIQUE Constraint
-- Ensures that all values in a column are different.
-- Example (during table creation):
-- CREATE TABLE users (
--     id INT PRIMARY KEY,
--     email VARCHAR(100) UNIQUE
-- );
-- Add UNIQUE using ALTER TABLE:
ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE(email); 
-- It adds a unique constraint to the email column after the table is created.

-- 2. NOT NULL Constraint
-- Ensures that a column cannot contain NULL values.
CREATE TABLE users (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Change an existing column to NOT NULL:
ALTER TABLE users MODIFY COLUMN name VARCHAR(100) NOT NULL;

-- Make a column nullable again:
ALTER TABLE users MODIFY COLUMN name VARCHAR(100) NULL;


-- 3. CHECK Constraint
-- Ensures that values in a column satisfy a specific condition.
-- Example: Allow only dates of birth after Jan 1, 2000
ALTER TABLE users ADD CONSTRAINT chk_dob CHECK (date_of_birth > '2000-01-01');
-- here it means, every date_of_birth in the table must be later than 1st Jan 2000.
-- If you try to insert or update a row with date_of_birth on or before 2000-01-01, MySQL will reject it.
-- EXAMPLE:
-- INSERT INTO users (name, date_of_birth)
-- VALUES ('Ali', '1999-05-12'); -- ❌ will fail
-- INSERT INTO users (name, date_of_birth)
-- VALUES ('Sara', '2002-03-15'); -- ✅ will work

-- 4. DEFAULT Constraint
-- Sets a default value for a column if none is provided during insert.
CREATE TABLE users (
    id INT PRIMARY KEY,
    is_active BOOLEAN DEFAULT TRUE
);

-- Add DEFAULT using ALTER TABLE:
ALTER TABLE users ALTER COLUMN is_active SET DEFAULT TRUE;

-- 5. PRIMARY KEY Constraint
-- Uniquely identifies each row. Must be NOT NULL and UNIQUE.
-- CREATE TABLE users (
--     id INT PRIMARY KEY,
--     name VARCHAR(100)
-- );

-- Add later with ALTER TABLE:
ALTER TABLE users ADD PRIMARY KEY (id);

-- 6. AUTO_INCREMENT
-- Used with PRIMARY KEY to automatically assign the next number.
-- CREATE TABLE users (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(100)
-- );
-- Each new row gets the next available integer value in id.

-- Summary Table:
-- Constraint	      Purpose
-- UNIQUE	          Prevents duplicate values
-- NOT NULL	          Ensures value is not NULL
-- CHECK	          Restricts values using a condition
-- DEFAULT	          Sets a default value
-- PRIMARY KEY	      Uniquely identifies each row
-- AUTO_INCREMENT	  Automatically generates unique numbers

-- SQL Functions(MySQL):
-- In SQL, a function is a reusable piece of code that takes input values (arguments/parameters), 
-- performs an operation, and returns a single value.

-- Types of SQL Functions:
-- 1.Built-in Functions (provided by SQL itself)
--    a.Scalar functions → return a single value per row.
      --    SELECT UPPER('mantasha');      -- Converts to uppercase
      --    SELECT ROUND(123.456, 2);      -- Rounds to 2 decimal places
      --    SELECT LEN('Hello');           -- Length of string (varies by DBMS)
-- Types of Scaler Function:
-- 1. String Functions – Work with text data
-- | Function      | Example                                  | Output       |
-- | ------------- | ---------------------------------------- | ------------ |
-- | `UPPER()`     | `SELECT UPPER('mantasha');`              | `MANTASHA`   |
-- | `LOWER()`     | `SELECT LOWER('SQL');`                   | `sql`        |
-- | `CONCAT()`    | `SELECT CONCAT('AI',' ','Chatbot');`     | `AI Chatbot` |
-- | `LENGTH()`    | `SELECT LENGTH('Hello');`                | `5`          |
-- | `SUBSTRING()` | `SELECT SUBSTRING('DataScience', 5, 3);` | `Sci`        |


-- 2. Numeric Functions – Work with numbers
-- | Function  | Example                    | Output  |
-- | --------- | -------------------------- | ------- |
-- | `ABS()`   | `SELECT ABS(-10);`         | `10`    |
-- | `ROUND()` | `SELECT ROUND(12.345, 2);` | `12.35` |
-- | `CEIL()`  | `SELECT CEIL(4.2);`        | `5`     |
-- | `FLOOR()` | `SELECT FLOOR(4.8);`       | `4`     |
-- | `MOD()`   | `SELECT MOD(10, 3);`       | `1`     |

-- 3. Date & Time Functions – Work with dates and times
-- | Function      | Example                                        | Output                |
-- | ------------- | ---------------------------------------------- | --------------------- |
-- | `CURDATE()`   | `SELECT CURDATE();`                            | `2025-08-15`          |
-- | `NOW()`       | `SELECT NOW();`                                | `2025-08-15 16:30:00` |
-- | `YEAR()`      | `SELECT YEAR('2025-08-15');`                   | `2025`                |
-- | `MONTHNAME()` | `SELECT MONTHNAME('2025-08-15');`              | `August`              |
-- | `DATEDIFF()`  | `SELECT DATEDIFF('2025-12-31', '2025-01-01');` | `364`                 |


-- 4. Conversion Functions
-- | Function      | Example                                | Output               | Description                                          |
-- | ------------- | -------------------------------------- | -------------------- | ---------------------------------------------------- |
-- | **CAST()**    | `SELECT CAST(123.45 AS CHAR) AS val;`  | `123.45` *(as text)* | Converts a value to a different data type.           |
-- | **CONVERT()** | `SELECT CONVERT(123.45, CHAR) AS val;` | `123.45` *(as text)* | Converts a value to another type or character set.   |
-- | **BINARY()**  | `SELECT BINARY 'sql' = 'SQL' AS val;`  | `0`                  | Makes value case-sensitive for comparisons.          |
-- | **HEX()**     | `SELECT HEX('ABC') AS val;`            | `414243`             | Converts a string to its hexadecimal representation. |
-- | **UNHEX()**   | `SELECT UNHEX('414243') AS val;`       | `ABC`                | Converts hexadecimal back to the original string.    |



-- 5. Control Flow Functions – Add conditional logic
-- | Function   | Example                               | Output |
-- | ---------- | ------------------------------------- | ------ |
-- | `IF()`     | `SELECT IF(500>1000, 'High', 'Low');` | `Low`  |
-- | `IFNULL()` | `SELECT IFNULL(NULL, 'N/A');`         | `N/A`  |
-- | `CASE`     |                                       |        |


--    b.Aggregate functions → operate on a set of rows and return one value.
      -- 4. Aggregate Functions – Summarize multiple rows into one result
-- | Function  | Example                              | Output            |
-- | --------- | ------------------------------------ | ----------------- |
-- | `COUNT()` | `SELECT COUNT(*) FROM employees;`    | `Total rows`      |
-- | `SUM()`   | `SELECT SUM(salary) FROM employees;` | `Sum of salaries` |
-- | `AVG()`   | `SELECT AVG(salary) FROM employees;` | `Average salary`  |
-- | `MIN()`   | `SELECT MIN(salary) FROM employees;` | `Lowest salary`   |
-- | `MAX()`   | `SELECT MAX(salary) FROM employees;` | `Highest salary`  |

      -- SELECT COUNT(*) FROM employees;  -- Total rows
      -- SELECT AVG(salary) FROM employees; -- Average salary
      -- SELECT MAX(salary) FROM employees; -- Maximum salary
-- Aggregate Functions
-- Yes → They are inbuilt (built-in) functions in SQL/MySQL.
-- No → They are not scalar functions because:
-- Scalar functions work on one row at a time and return one value per row.
-- Aggregate functions work on multiple rows together and return one value per group (or whole table).


-- 2.User-Defined Functions (UDFs)
--    Created by users to perform specific tasks.

-- Code with Harry Functions in MYSQL:
-- 1. Aggregate Functions
-- These return a single value from a set of rows.
-- COUNT()
-- Count total number of users:
SELECT COUNT(*) from users;
SELECT * FROM USERS;

-- Count users who are Female:
SELECT COUNT(*) from users WHERE gender="Female";

-- MIN() and MAX()
-- Get the minimum and maximum salary:
SELECT MIN(salary) as min_salary, MAX(salary) as max_salary from users;

-- SUM()
-- Calculate total salary payout:
SELECT SUM(salary) as total_payroll from users;

-- AVG()
-- Find average salary:
SELECT AVG(salary) as average_salary from users;

-- average salary of male
SELECT AVG(salary) as average_salary from users WHERE gender="Male";

-- Grouping with GROUP BY
-- Average salary by gender:
SELECT gender as sex, AVG(salary) AS avg_salary FROM users GROUP BY gender;

-- 2. String Functions
-- LENGTH()
-- Length of user names:
SELECT LENGTH(name) AS name_length FROM users;            -- (will give only length of names sequentially)
SELECT name as name_of_user, LENGTH(name) as name_length from users; -- ( will give name and length both)

-- LOWER() and UPPER()
-- Convert names to lowercase or uppercase:
SELECT name, LOWER(name) AS lowercase_name FROM users;
SELECT name, UPPER(name) AS uppercase_name FROM users;

-- CONCAT()
-- Combine name and email:
SELECT CONCAT(name,"<",email,">") as user_contact from users;

-- complex string function query:
SELECT id, gender,lOWER(name) as lower,CONCAT(LOWER(name),"5677") as username from users;
