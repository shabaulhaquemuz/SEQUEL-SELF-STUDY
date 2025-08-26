-- Stored Procedures in MySQL
-- A stored procedure is a saved SQL block that can be executed later. It's useful when you want to encapsulate
-- logic that can be reused multiple times — like queries, updates, or conditional operations.

-- Delimeter:
-- In SQL, a delimiter is a symbol (like ;, //, $$) used to mark the end of a statement or block of code.

-- Why Change the Delimiter?
-- By default, MySQL uses ; to end SQL statements.
-- But when defining stored procedures, we use ; inside the procedure as well. This can confuse MySQL. 
-- To avoid this, we temporarily change the delimiter (e.g. to $$ or //) while creating the procedure.

-- Syntax for Creating a Stored Procedure
DELIMITER $$
CREATE PROCEDURE select_users()
BEGIN
SELECT * FROM users;
END $$
DELIMITER ;

-- After the procedure is created, we reset the delimiter back to ;.

-- Meaning of IN:
-- It tells SQL that the parameter is an input parameter.
-- You only pass a value into the procedure when calling it.

-- Creating a Procedure with Input Parameters
-- Let’s say you want to create a stored procedure that inserts a new user into the users table.

-- Example:
DELIMITER $$
CREATE PROCEDURE Adduser(
IN p_name VARCHAR(100),
IN p_email VARCHAR(100),
IN p_gender ENUM("Male","Female","Others"),
IN p_dob DATE,
IN p_salary INT
)
BEGIN
INSERT INTO users(name,email,gender,date_of_birth,salary)
VALUES (p_name,p_email,p_gender,p_dob,p_salary);
END $$
DELIMITER ;
-- This creates a procedure named AddUser that accepts five input parameters.


-- Calling the Procedure
-- You can call the procedure using:
CALL Adduser("Shabaul Saif","shabaul@saif.com","Male","2000-01-23",80000);
-- This will insert the new user into the users table.
SELECT * FROM users;

-- Notes
-- Input parameters are declared using the IN keyword.
-- Stored procedures are stored in the database and can be reused.

-- Viewing Stored Procedures:
SHOW PROCEDURE STATUS WHERE Db="foreignsql";

-- Dropping a Stored Procedure:
-- DROP PROCEDURE IF EXISTS Adduser;

-- Summary
-- Command	Purpose
-- DELIMITER $$	Temporarily change statement delimiter
-- CREATE PROCEDURE	Defines a new stored procedure
-- CALL procedure_name(...)	Executes a stored procedure
-- DROP PROCEDURE	Removes an existing procedure





-- Triggers in MySQL
-- A trigger is a special kind of stored program that is automatically executed (triggered) when a 
-- specific event occurs in a table — such as INSERT, UPDATE, or DELETE.

-- log: A log is simply a record that keeps track of actions or changes in a table (like a history).
-- Logging is the process of creating a log (the record of events or changes). 

-- Triggers are commonly used for:
-- Logging changes
-- Enforcing additional business rules
-- Automatically updating related data

-- Basic Trigger Structure:
-- CREATE TRIGGER trigger_name
-- AFTER INSERT ON table_name
-- FOR EACH ROW
-- BEGIN
--     -- STATEMENTS TO BE EXECUTED
-- END


-- Triggers can be fired:
-- BEFORE or AFTER an event
-- On INSERT, UPDATE, or DELETE

-- Scenario: Log Every New User Insertion
-- Suppose we want to log every time a new user is inserted into the users table. 
-- We'll create a separate table called user_log to store log entries.

-- Step 1: Create the Log Table
CREATE TABLE user_log(
id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
name VARCHAR(100),
created_on TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 2: Create the Trigger
-- We now define a trigger that runs after a new user is added.

DELIMITER $$
CREATE TRIGGER after_user_insert
AFTER INSERT ON users
FOR EACH ROW
BEGIN
     INSERT INTO user_log(user_id,name)
     VALUES (NEW.id,NEW.name);
END $$
DELIMITER ;

INSERT INTO users (name,email,gender,date_of_birth,salary)
VALUES("Shariful Haque","sharif@gmail.com","Male","1965-10-12",120000);
INSERT INTO users (name,email,gender,date_of_birth,salary)
VALUES("Shariful","shariful@gmail.com","Male","1965-10-12",120000);

INSERT INTO users (name,email,gender,date_of_birth,salary)
VALUES("Zulekha","zulekha@gmail.com","Female","1965-10-12",120000),
      ("Ali","ali@gmail.com","Male","2000-02-20",190000);

SELECT * FROM users;
SELECT * FROM user_log;

-- Step 3: Test the Trigger(also can be inserted using procedure we have created to insert a user)
CALL AddUser('Ritu', 'ritu@example.com', 'Female', '1996-03-12', 74000);

-- Now check the user_log table:
SELECT * FROM user_log;
-- You should see Ritika's info automatically logged.

-- Dropping a Trigger
-- If you need to remove a trigger:
-- DROP TRIGGER IF EXISTS after_user_insert;

-- Summary
-- Trigger Component	Description
-- BEFORE / AFTER	When the trigger runs
-- INSERT / UPDATE / DELETE	What kind of action triggers it
-- NEW.column	Refers to the new row (for INSERT, UPDATE)
-- OLD.column	Refers to the old row (for UPDATE, DELETE)
-- FOR EACH ROW	Executes for each affected row

-- More on MySQL
-- This section covers some essential MySQL features and operators that help you write more 
-- powerful and flexible queries.

-- 1. Logical Operators
-- Logical operators are used to combine multiple conditions in a WHERE clause.
-- Operator	Description	Example
-- AND	All conditions must be true	salary > 50000 AND gender = 'Male'
-- OR	At least one condition is true	gender = 'Male' OR gender = 'Other'
-- NOT	Reverses a condition	NOT gender = 'Female'


-- 2. Add a Column to an Existing Table
-- Use ALTER TABLE to add a column:
ALTER TABLE users ADD COLUMN city VARCHAR(100);
-- This adds a new column named city to the users table.

-- 3. Wildcard Operators
-- Wildcards are used with the LIKE operator for pattern matching in text.
-- Wildcard	Description	Example
-- %	Matches any sequence	WHERE name LIKE 'A%' (starts with A)
-- _	Matches a single character	WHERE name LIKE '_a%' (second letter is 'a')
SELECT * FROM users WHERE name LIKE "A%";
SELECT * FROM users WHERE name LIKE "_A%";
SELECT * FROM users WHERE name LIKE "_A_H%";

-- 4. LIMIT with OFFSET
-- LIMIT is used to limit the number of rows returned. OFFSET skips a number of rows before starting to
-- return rows.

SELECT * FROM users 
LIMIT 10;
SELECT * FROM users LIMIT 5 OFFSET 10; -- This skips the first 10 rows and returns the next 5.
-- Alternative syntax:
SELECT * FROM users LIMIT 10, 5;  -- HERE 10 IS OFFSET AND 5 IS LIMIT
-- This also skips 10 and returns 5 (syntax: LIMIT offset, count).


-- 5. DISTINCT Keyword
-- DISTINCT is used to return only unique values.
SELECT gender FROM users; -- return all genders
SELECT DISTINCT gender FROM users; --  return each gender for just once

-- 6. TRUNCATE Keyword
-- TRUNCATE removes all rows from a table, but keeps the table structure.
-- TRUNCATE TABLE users;
-- Faster than DELETE FROM users
-- Cannot be rolled back (unless in a transaction-safe environment)


-- 7. CHANGE vs MODIFY Column
-- Both CHANGE and MODIFY are used to alter existing columns in a table, but they work slightly differently.

-- CHANGE: Rename and change datatype
ALTER TABLE users CHANGE COLUMN city location VARCHAR(100);
SELECT * FROM users;
-- This renames city to location and changes its type

-- MODIFY: Only change datatype
ALTER TABLE users MODIFY COLUMN salary BIGINT;
-- This changes only the datatype of salary.
