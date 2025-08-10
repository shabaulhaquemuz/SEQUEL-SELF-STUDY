-- > creating a database		
CREATE database startersql;  -- shows 1 row affectted
-- using a database(1. write use database_name, 2.right click on database_name in schemas section, 
-- then click on set as default schema )
use startersql;  -- shows 0 rows affected
-- > ROWS AFFECTED MEANING:
-- 0 rows affected → Query ran but didn’t change any data.
-- 1 row affected → Query ran and modified exactly one row.

-- > creating a table(syntax: column_name, its_datatype,constraints)
-- In id column, INT is datatype,AUTO_INCREMENT is a constraint,PRIMARY KEY is another constraint

-- ENUM is a special data type in SQL that stores one value from a predefined list of allowed values.

-- DATE is a data type in SQL used to store calendar dates (year, month, day).

-- TIMESTAMP is a datatype that stores date and time,and DEFAULT CURRENT_TIMESTAMP is a default value 
-- setting THAT tells the database to automatically use the current date and time when a new record is 
-- inserted in a column like TIMESTAMP OR DATETIME.
-- Databases get the current date and time from the server’s system clock — 
-- the computer where the database is running.
CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
gender ENUM("Male","Female","Others"),
date_of_birth DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- > TO CHECK IF THE TABLE IS CREATED
-- To check if a table is created in SQL, you can use:
SHOW TABLES;

-- >DESCRIBE table_name; shows the structure (columns, data_types, keys) of the specified table.
DESCRIBE users;

-- > SELECT * FROM table_name; fetches all columns and all rows along with their actual values 
-- from the table.
SELECT * FROM users;

-- > select specific columns from the table
-- This fetches only the id and email columns from all rows in the users table.
SELECT id, email FROM users;

-- > dropping the database
-- we can delete the entire database (and all its tables) using: DROP DATABASE database_name;
DROP DATABASE startersql;

-- > the database is deleted now.. so we will again make it one go...
CREATE database startersql;
use startersql;
CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
gender ENUM("Male","Female","Others"),
date_of_birth DATE,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
SELECT * FROM users;


-- > DATATYPES IN SQL:
-- Data Types Explained:
-- 1.INT: Integer type, used for whole numbers.

-- 2. VARCHAR(100): stands for variable character.
-- It stores variable-length strings (text, numbers, symbols).
-- In VARCHAR, numbers and symbols are stored as strings (text), not as numeric values.

-- In standard SQL (like in SQL Server), the maximum length for VARCHAR is:
-- VARCHAR(n): up to 8,000 characters
-- For longer strings, use VARCHAR(MAX), which can store up to 2^31 bytes(characters)

-- 3.ENUM: A string object with a value chosen from a list of permitted values. 
-- eg. gender ENUM('Male', 'Female', 'Other')

-- 4.DATE: Stores date values. eg date_of_birth DATE

-- 5.TIMESTAMP: Stores date and time, automatically set to the current timestamp when a row is created.

-- 6.BOOLEAN: Stores TRUE or FALSE values, often used for flags like is_active.

-- 7.DECIMAL(10, 2): Stores exact numeric data values, useful for financial data. 
-- The first number is the total number of digits, and the second is the number of digits after 
-- the decimal point.

-- > Constraints Explained
-- 1.AUTO_INCREMENT: AUTO_INCREMENT automatically generates a unique sequential number for each new row 
-- inserted in a table(usually used for primary keys).

-- 2. PRIMARY KEY: Uniquely identifies each row in the table and it cant be null.

-- 3. NOT NULL: Ensures a column cannot have a NULL value.

-- 4. UNIQUE: Ensures all values in a column are different.

-- 5. DEFAULT: Sets a default value for a column if no value is provided. 
--  eg. created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, 

-- 6. is_active BOOLEAN DEFAULT TRUE: is_active BOOLEAN DEFAULT TRUE creates a column 
-- that stores true/false values and sets it to true by default.

-- > SELECTING DATA FROM A TABLE
-- > 1.Select All Columns
SELECT * from users;

-- > 2.Select Specific Columns
SELECT name, email FROM users;

-- > 3. Renaming a Table
RENAME TABLE users to programmers;

-- > 4. To rename it back
RENAME TABLE programmers TO users;

-- > ALTERING A TABLE
-- You can use ALTER TABLE to modify an existing table.
-- 1. ADD A COLUMN
ALTER TABLE users ADD COLUMN is_active BOOLEAN DEFAULT TRUE;
SELECT *  FROM users;

-- 2. DROP A COLUMN
ALTER TABLE users DROP is_active;
SELECT * FROM users;

-- 3. MODIFY A COLUMN TYPE
ALTER TABLE users MODIFY COLUMN name VARCHAR(150);

-- 4. CHANGING A COLUMN POSITION
ALTER TABLE users MODIFY COLUMN email VARCHAR(100) after id;

-- 4. CHANGING A COLUMN POSITION TO FIRST
ALTER TABLE users MODIFY COLUMN date_of_birth DATETIME FIRST;


-- > INSERTING DATA
-- 1. Inserting Data into tables
USE startersql;
INSERT INTO users VALUES
("2001-02-27",2,"shabanaperween2025@gmail.com","shabana perween","Female",default);

-- 2.Inserting using the Column name (Without AUTO_INCREMENT, you must manually provide a unique ID value for each new row.)
INSERT INTO users (name,id,email,gender) VALUES
("saif","saif@gmail.com","male");

-- 3. Inserting multiple rows of data
-- if you’re not using column names and you have an AUTO_INCREMENT
-- column like id, you must put DEFAULT (or NULL) in its place.
-- inserting multiple rows at once is more efficient than inserting rows one by one
INSERT INTO users VALUES
("2001-03-29",default,"sameermirza@gmail.com","sameer mirza","male",default),
("2005-02-20",default,"amaan@gmail.com","amaan","male",default),
("2003-05-29",default,"pritam@gmail.com","pritam","male",default),
("1997-08-29",default,"jibran@gmail.com","jibran","male",default);

INSERT INTO users
VALUES ('2001-03-29', DEFAULT, 'testuser@gmail.com', 'Test User', 'male', DEFAULT);

INSERT INTO users (date_of_birth, id, email, name, gender, created_at)
VALUES ('2001-03-29', 4, 'arjun@gmail.com', 'arjun mahaseth', 'male', DEFAULT);


