-- SQL JOINS
-- In SQL, JOINs are used to combine rows from two or more tables based on related columns — usually a 
-- foreign key in one table referencing a primary key in another.

-- Types of joins:
-- INNER JOIN → Only matches.
-- LEFT JOIN → All left + matches.
-- RIGHT JOIN → All right + matches.
-- FULL JOIN → All left + all right (via UNION).
-- CROSS JOIN → All combinations.


-- We’ll use the following two tables:
-- users table
-- id	name
-- 1	Aarav
-- 2	Sneha
-- 3	Raj

-- addresses table
-- id	user_id	city
-- 1	1	Mumbai
-- 2	2	Kolkata
-- 3	4	Delhi
-- Note: user_id is a foreign key that references users.id.
select * from users;
select * from addresses;
USE foreignsql;
-- Returns only the matching rows from both tables.
SELECT users.name,addresses.city 
FROM users
INNER JOIN addresses on addresses.user_id = users.id;

-- Output:
-- name	city
-- Aarav	Mumbai
-- Sneha	Kolkata
-- Raj is excluded because there is no matching address. Delhi is excluded because 
-- its user_id (4) is not in users.

-- 2. LEFT JOIN
-- Returns all rows from the left table (users), and matching rows from the right table (addresses). 
-- If no match is found, NULLs are returned.
SELECT users.name, addresses.city
FROM users
LEFT JOIN addresses ON users.id=addresses.user_id;
-- Output:
-- name	city
-- Aarav	Mumbai
-- Sneha	Kolkata
-- Raj	NULL
-- Raj is shown even though he doesn’t have an address.
-- Visual Representation:
-- users          addresses
--  -----           ------
-- |  1  |         |  1  |
-- |  2  |         |  2  |
-- |  3  |         |     |
--  => all users + matched addresses (or NULL)



-- 3. RIGHT JOIN
-- Returns all rows from the right table (addresses), and matching rows from the left table (users).
--  If no match is found, NULLs are returned.
SELECT users.name, addresses.city
FROM users
RIGHT JOIN addresses on users.id=addresses.user_id;
-- Output:
-- name	city
-- Aarav	Mumbai
-- Sneha	Kolkata
-- NULL	Delhi
-- Delhi is shown even though it points to a user_id that doesn't exist.
-- Visual Representation:
-- users          addresses
--  -----           ------
-- |  1  |         |  1  |
-- |  2  |         |  2  |
-- |     |         |  4  |
--  => all addresses + matched users (or NULL)

-- Summary Table
-- JOIN Type	Description
-- INNER JOIN	Only matching rows from both tables
-- LEFT JOIN	All rows from left table + matching from right
-- RIGHT JOIN	All rows from right table + matching from left


-- CROSS JOIN
-- A CROSS JOIN returns the Cartesian product of two tables, i.e.,
-- all possible row combinations between them.

-- CROSS JOIN makes a Cartesian product → every row in users is combined with every row in addresses.
-- users has 3 rows
-- addresses has 3 rows
-- Result = 3 × 3 = 9 rows

-- SQL UNION and UNION ALL
-- The UNION operator in SQL is used to combine the result sets of two or more SELECT statements. It removes duplicates by default.
-- If you want to include all rows including duplicates, use UNION ALL.

-- Example Scenario
-- You already have a users table for active users. Now, we’ll create an admin_users table to store 
-- users who are administrators or have special roles. We will then combine the names from both 
-- tables using UNION.

-- Step 1: Create the admin_users Table
CREATE TABLE admin_users (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    salary INT
);
-- Step 2: Insert Sample Data into admin_users
INSERT INTO admin_users (id, name, email, gender, date_of_birth, salary) VALUES
(101, 'Anil Kumar', 'anil@example.com', 'Male', '1985-04-12', 60000),
(102, 'Pooja Sharma', 'pooja@example.com', 'Female', '1992-09-20', 58000),
(103, 'Rakesh Yadav', 'rakesh@example.com', 'Male', '1989-11-05', 54000),
(104, 'Fatima Begum', 'fatima@example.com', 'Female', '1990-06-30', 62000);

-- Step 3: Use UNION to Combine Data
-- Let’s combine the active and admin user names
select * from users;
select * from admin_users;

SELECT name FROM users
UNION
SELECT name FROM admin_users;
-- This returns a single list of unique names from both tables.

-- Using More Than One Column
-- You can also select multiple columns as long as both SELECT queries return the 
-- same number of columns with compatible types.
SELECT name, salary FROM users
UNION
SELECT name, salary FROM admin_users;

-- Adding separate roles
SELECT name,"User" as role FROM users
UNION
SELECT name,"Admin" as role FROM admin_users;


-- Using Order By with UNION
SELECT name FROM users
UNION
SELECT name FROM admin_users
ORDER BY name;

-- Rules of UNION
-- The number of columns and their data types must match in all SELECT statements.
-- UNION removes duplicates by default.
-- UNION ALL keeps duplicates.

-- When to Use UNION
-- When you have two similar tables (like current and archived data).
-- When you need to combine filtered results (e.g., high-salary users from two sources).
-- When performing cross-category reporting.

-- Summary
-- Operator	Behavior
-- UNION	Combines results, removes duplicates
-- UNION ALL	Combines results, keeps duplicates

-- SELF JOIN
-- A self join is a join where a table is joined with itself.
-- We use it when we want to compare rows within the same table.
-- This is useful when rows in the same table are related to each other.
-- For example, when users refer other users, and we store the ID of 
-- the person who referred them in the same users table.

-- Step 1: Add a referred_by_id Column
-- We’ll extend the existing users table to include a column called referred_by_id, 
-- which holds the id of the user who referred them.
ALTER TABLE users ADD COLUMN referred_by_id INT;
SELECT * FROM users;

-- This column:
-- Will be NULL for users who were not referred.
-- Will contain the id of another user who referred them.

-- Step 2: Insert Referral Data (Optional)
-- Assuming id = 1 is the first user, and referred others:

UPDATE users SET referred_by_id=1 WHERE id IN(2,3,4,5,6);
UPDATE users SET referred_by_id=2 WHERE id IN(19,20,25);


-- Step 3: Use a Self JOIN to Get Referrer Names
-- We want to get each user’s name along with the name of the person who referred them.

SELECT a.id,a.name AS user_name,
b.name as referred_by
FROM users a
LEFT JOIN users b ON b.id=a.referred_by_id;

-- Explanation:
-- a refers to the user being queried.
-- b refers to the user who referred them.
-- LEFT JOIN is used so that users with NULL in referred_by_id are also included.

-- Summary
-- Use Self JOIN when you need to join a table with itself.
-- In referral-based relationships, store the referrer’s id in the same table.
-- Use aliases like a and b to differentiate the two instances of the same table.

-- MySQL Views
-- A view in MySQL is a virtual table based on the result of a SELECT query. 
-- It does not store data itself — it always reflects the current data present in the base tables.

-- Views are useful when:
-- You want to simplify complex queries
-- You want to reuse logic
-- You want to hide certain columns from users
-- You want a "live snapshot" of filtered data

-- Creating a View
-- Suppose we want a view that lists all users earning more than ₹70,000.
CREATE VIEW high_salary_users AS
SELECT id,name,salary 
FROM users WHERE salary>70000;

-- Querying the View
SELECT * FROM high_salary_users;
-- This will return all users from the users table where salary is above ₹70,000.

-- Demonstrating That a View is Always Up-To-Date
-- Let’s see what happens when the underlying data changes.
-- Step 1: View before update
SELECT * FROM high_salary_users;
-- Sample Output:
-- id	name	salary
-- 2	Sneha	75000
-- 5	Fatima	80000

-- Step 2: Update a user's salary
UPDATE users SET salary=50000 WHERE id=2;

--
SELECT * FROM high_salary_users;

-- Step 3: Query the view again
-- New Output:
-- id	name	salary
-- 5	Fatima	80000
-- 3	Raj	72000
-- user with id 2 has salary 50000 now after the update, thats why its not visible in the view

-- Dropping a View
-- To remove a view:
-- DROP VIEW high_salary_users;

-- Index in MYSQL:
-- An index in MySQL is a data structure (usually a B-tree) that improves the speed of data retrieval 
-- on a table.
-- It's like the index in a book: instead of reading every page, you jump directly to 
-- the page number using the index.
-- Similarly it helps the database engine to find the rows faster, especially for searches, filters, 
-- and joins.

-- ✅ Faster SELECT queries (searching, filtering, sorting, joins).
-- ✅ Helps enforce UNIQUE constraints.
-- ❌ Indexes Slows down INSERT, UPDATE, and DELETE a bit (because index also needs to be updated).
-- ❌ Indexes Uses extra disk space.


-- Viewing Indexes on a Table
-- To see the indexes on a table, use:
SHOW INDEXES FROM users;

-- This shows all the indexes currently defined on the users table,
-- including the automatically created primary key index.

-- Creating a Single-Column Index
-- Suppose you're frequently searching users by their email. You can speed this up by indexing the 
-- email column.

CREATE INDEX idx_email ON users(email);
-- What this does:
-- Creates an index named idx_email
-- Improves performance of queries like:
SELECT * FROM users WHERE email="example@example.com";

-- Important Notes
-- Indexes consume extra disk space
-- Indexes slow down INSERT, UPDATE, and DELETE operations slightly (because the index must be updated)
-- Use indexes only when needed (i.e., for columns used in WHERE, JOIN, ORDER BY)

-- Creating a Multi-Column Index
-- If you often query users using both gender and salary, a multi-column index is
-- more efficient than separate indexes.

-- CREATE INDEX multi_column ON users(gender,email);
-- SHOW INDEXES FROM users;
-- -- ✅ MySQL will first filter by gender (because it’s the left-most column in the index) and then use
-- --  the salary part of the index to quickly find matching rows.
-- -- This query can take advantage of the combined index on gender and salary.
-- -- The query runs faster because MySQL uses the combined index to quickly 
-- -- filter by gender first and then by salary.


-- Index Order Matters
-- For a multi-column index on (gender, salary):

-- This works efficiently:
-- WHERE gender = 'Female' AND salary > 70000

-- But this may not use the index effectively:
-- WHERE salary > 70000
-- Because the first column in the index (gender) is missing in the filter.


-- Dropping an Index
-- To delete an index:
-- DROP INDEX idx_email ON users;

-- Summary
-- Feature	Description
-- SHOW INDEXES	View current indexes on a table
-- CREATE INDEX	Create single or multi-column indexes
-- DROP INDEX	Remove an index
-- Use when	Query performance on large tables is a concern
-- Avoid on	Columns that are rarely queried or always unique

