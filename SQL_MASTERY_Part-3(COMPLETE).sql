-- By default, MySQL operates in AutoCommit mode. This means that every SQL statement is treated as a
-- transaction and is committed automatically. However, for more control over when changes are saved, 
-- you can turn AutoCommit off and manage transactions manually.
-- it means by default "SET autocommit=1;" is set in mysql, which means autocommit is enabled
-- and for each query we write changes are done permanently

-- 1. Disabling AutoCommit
-- When AutoCommit is off, you can explicitly control when to commit or rollback changes.
-- To disable AutoCommit:
-- SET autocommit = 0;
-- This turns off AutoCommit, meaning that changes you make won't be saved to the database 
-- unless you explicitly tell MySQL to commit them.
-- Important: Until you execute a COMMIT, your changes are not permanent.

-- 2. COMMIT — Save Changes to the Database
-- Once you’ve made changes and you’re confident that everything is correct,
-- you can use the COMMIT command to save those changes.
-- To commit a transaction:
-- COMMIT;
-- This saves all the changes made since the last COMMIT or ROLLBACK.
-- After this point, the changes become permanent.

-- 3. ROLLBACK — Revert Changes to the Last Safe Point
-- If you make an error or decide you don't want to save your changes,
-- you can rollback the transaction to its previous state.
-- To rollback a transaction:
-- ROLLBACK;
-- This undoes all changes since the last COMMIT or ROLLBACK.

-- Example Workflow
-- Here’s a simple example of using COMMIT and ROLLBACK in a transaction:
-- 1. Turn off AutoCommit:
SET autocommit=0;
-- Make some changes (e.g., updating a salary):
UPDATE users SET salary=80000 WHERE id=5;
SELECT * from users;
-- Decide whether to commit or rollback:
-- If you’re happy with the changes, run:
COMMIT;
-- If you’re not happy and want to revert the changes, run:
ROLLBACK;

-- 4. Enabling AutoCommit Again
-- If you want to turn AutoCommit back on (so that every statement is automatically committed), you can do so with:
SET autocommit = 1;

-- Best Practices:
-- Use COMMIT when you want to make changes permanent.
-- Use ROLLBACK to discard changes if something goes wrong.
-- Consider disabling AutoCommit when performing complex updates to avoid saving partial or incorrect data.

-- Understanding PRIMARY KEY in MySQL
-- A PRIMARY KEY is a constraint in SQL that uniquely identifies each row in a table. 
-- It is one of the most important concepts in database design.
-- What is a Primary Key?
-- A PRIMARY KEY:
-- Must be unique
-- Cannot be NULL
-- Is used to identify rows in a table
-- Can be a single column or a combination of columns
-- Each table can have only one primary key

-- EXAMPLE:
-- CREATE TABLE users (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(100)
-- );

-- How Is PRIMARY KEY Different from UNIQUE?
-- At first glance, PRIMARY KEY and UNIQUE might seem similar since both prevent duplicate values. 
-- But there are important differences:
-- Feature	                    PRIMARY KEY	                        UNIQUE
-- Must be unique	                Yes	                              Yes
-- Allows NULL values	            No	                              Yes (one or more NULLs allowed)
-- How many allowed	            Only one per table	              Can have multiple
-- Required by table	            Recommended, often required	      Optional
-- Dropping	                    Cannot be easily dropped	      Can be dropped anytime

-- Example with UNIQUE:
-- CREATE TABLE users (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     email VARCHAR(100) UNIQUE,
--     name VARCHAR(100)
-- );
-- In this example:
-- id is the unique identifier for each row.
-- email must be unique, but is not the primary key.

-- Can I Drop a PRIMARY KEY?
-- Yes, but it is more restricted than dropping a UNIQUE constraint.
-- ALTER TABLE users DROP PRIMARY KEY;
-- This may fail if the primary key is being used elsewhere 
-- (like in a foreign key or auto_increment column).

-- To drop a UNIQUE constraint:
-- ALTER TABLE users DROP INDEX email;


-- Auto Increment
-- In MySQL, a PRIMARY KEY is often used with the AUTO_INCREMENT attribute to 
-- automatically generate unique values for new rows.
-- CREATE TABLE users (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(100)
-- );

-- This means that every time you insert a new row, MySQL will automatically assign a unique value to the id column. 

-- You can change the starting value of AUTO_INCREMENT using:
-- ALTER TABLE users AUTO_INCREMENT = 1000;

-- Key Takeaways
-- Use PRIMARY KEY for the main identifier of a row.
-- Use UNIQUE for enforcing non-duplicate values in other columns (like email or phone).
-- You can have only one primary key, but you can have many unique constraints.


-- Foreign Keys in MySQL:
-- A foreign key is a column that creates a link between two tables.
-- It ensures that the value in one table must match a value in another table.
-- This is used to maintain data integrity between related data.

-- Why Use Foreign Keys?
-- Imagine this scenario:
-- You have a users table. Now you want to store each user's address. Instead of putting address columns 
-- inside the users table, you create a separate addresses table, and link it to users using a foreign key.

-- A Foreign Key is a column in one table that refers to the Primary Key in another table.
-- It creates a relationship between the two tables.
-- It ensures referential integrity → you can’t insert a value in the foreign key column unless it exists in the primary key 
-- column of the referenced table.

-- Creating a Table with a Foreign Key
-- Let’s create an addresses table where each address belongs to a user.


CREATE DATABASE IF NOT EXISTS foreignsql;
USE foreignsql;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    salary DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

USE foreignsql;
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


use foreignsql;
show tables;
describe users;




USE foreignsql;
DROP TABLE IF EXISTS addresses;
CREATE TABLE addresses (
id INT AUTO_INCREMENT PRIMARY KEY,
user_id INT,
street VARCHAR(255),
city VARCHAR(100),
state VARCHAR(100),
pincode VARCHAR(10),
CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO addresses (user_id, street, city, state, pincode)
VALUES
(1, '221B MG Road', 'Mumbai', 'Maharashtra', '400001'),
(22, '14 Park Street', 'Kolkata', 'West Bengal', '700016'),
(3, '32 Residency Road', 'Bengaluru', 'Karnataka', '560025'),
(24, '5 North Usman Road', 'Chennai', 'Tamil Nadu', '600017'),
(5, '17 Hazratganj', 'Lucknow', 'Uttar Pradesh', '226001'),
(6, '55 Banjara Hills', 'Hyderabad', 'Telangana', '500034'),
(7, '88 Connaught Place', 'Delhi', 'Delhi', '110001'),
(8, '10 MG Marg', 'Dehradun', 'Uttarakhand', '248001'),
(9, '23 Brigade Road', 'Bengaluru', 'Karnataka', '560025'),
(10, '45 Marine Drive', 'Mumbai', 'Maharashtra', '400020'),
(11, '67 Ashoka Road', 'Delhi', 'Delhi', '110001'),
(12, '89 MG Road', 'Pune', 'Maharashtra', '411001'),
(13, '12 Brigade Road', 'Bengaluru', 'Karnataka', '560025'),
(14, '34 Park Street', 'Kolkata', 'West Bengal', '700016'),
(15, '56 Connaught Place', 'Delhi', 'Delhi', '110001'),
(16, '78 Marine Drive', 'Mumbai', 'Maharashtra', '400020'),
(17, '90 MG Marg', 'Dehradun', 'Uttarakhand', '248001'),
(18, '11 North Usman Road', 'Chennai', 'Tamil Nadu', '600017'),
(19, '33 Residency Road', 'Bengaluru', 'Karnataka', '560025'),
(20, '22 Hazratganj', 'Lucknow', 'Uttar Pradesh', '226001');

select * from addresses;

-- 1. Primary Key vs Foreign Key
-- Primary Key → Uniquely identifies rows in its own table. (No duplicates, no NULLs).
-- Foreign Key → Refers to that Primary Key, but it is not the same thing. It’s just a reference.

-- Dropping a Foreign Key
-- To drop a foreign key, you need to know its constraint name. MySQL auto-generates 
-- it if you don’t specify one, or you can name it yourself:

-- CREATE TABLE addresses (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     user_id INT,
--     CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id)
-- );

-- To drop it:
-- ALTER TABLE addresses
-- DROP FOREIGN KEY fk_user;

-- Adding a Foreign Key Later (Using ALTER)
-- Suppose the foreign key was not defined during table creation. You can add it later using ALTER TABLE:
-- ALTER TABLE addresses
-- ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id);

-- Adding ON DELETE Action
-- By default, if you delete a user that has related addresses, MySQL will throw an error. You can control this behavior with ON DELETE.

-- Example with ON DELETE CASCADE:
-- If you want addresses to be automatically deleted when the user is deleted:

-- CREATE TABLE addresses (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     user_id INT,
--     street VARCHAR(255),
--     city VARCHAR(100),
--     state VARCHAR(100),
--     pincode VARCHAR(10),
--     CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
-- );


-- or alter it later:
-- ALTER TABLE addresses
-- ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


-- Other ON DELETE Options
-- ON DELETE Option	Behavior
-- CASCADE	Deletes all related rows in child table
-- SET NULL	Sets the foreign key to NULL in the child table
-- RESTRICT	Prevents deletion of parent if child exists (default)

-- Summary:
-- Foreign keys connect tables and enforce valid references.
-- You can create them inline or with ALTER TABLE.
-- You can drop them by name.
-- Use ON DELETE to control what happens when the parent row is deleted.


