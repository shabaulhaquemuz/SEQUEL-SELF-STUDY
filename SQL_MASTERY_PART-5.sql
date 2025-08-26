-- Subqueries in MySQL
-- A subquery is a query nested inside another query. Subqueries are useful for breaking down 
-- complex problems into smaller parts.

-- They can be used in:
-- SELECT statements
-- WHERE clauses
-- FROM clauses

-- Example Scenario: Salary Comparison
-- Suppose we want to find all users who earn more than the average salary of all users.

-- Scalar Subquery Example
-- This subquery returns a single value — the average salary — and we compare each user's salary against it.
SELECT AVG(salary) FROM users;
SELECT * FROM users WHERE salary>(SELECT AVG(salary) FROM users);
-- Explanation:
-- The inner query: SELECT AVG(salary) FROM users returns the average salary.
-- The outer query selects all users with a salary greater than that average.

-- Subquery with IN
-- Now let's say we want to find users who have been referred by someone who earns more than ₹75,000.

SELECT id,name,referred_by_id FROM users WHERE referred_by_id IN( SELECT id FROM users WHERE salary>75000);
SELECT *FROM USERS;
SELECT id FROM users WHERE salary>75000;
-- Explanation:
-- The inner query: SELECT id FROM users WHERE salary > 75000 returns a list of user IDs (referrers) 
-- who earn more than ₹75,000.
-- The outer query selects users whose referred_by_id is in that list.

-- Difference from Other Subqueries
-- Scalar subquery → returns one value.
-- Row subquery → returns one row, multiple columns.
-- Table subquery → returns a full result set (multiple rows & columns).

-- Other Places Subqueries Are Used
-- You can also use subqueries:
-- Inside SELECT columns (called scalar subqueries)
-- In the FROM clause to create derived tables

-- Example in SELECT:
SELECT name as name_of_users,salary as salary_of_users,(SELECT AVG(salary) FROM users) as Average_Salary FROM users;
-- This shows each user's salary along with the overall average.

-- Summary
-- | Subquery Type          | Easy Meaning                                          | Example Use                                                           |
-- | ---------------------- | ----------------------------------------------------- | --------------------------------------------------------------------- |
-- | **Scalar Subquery**    | Gives back **only one value** (single number or text) | Find employees earning more than the **average salary**               |
-- | **Subquery with IN**   | Gives back **a list of values**                       | Find users whose manager id is in a list of **high-salary employees** |
-- | **Subquery in SELECT** | Shows an **extra calculated column** for each row     | Show each user with their **department name** from another table      |
-- | **Subquery in FROM**   | Treated like a **temporary table**                    | Use a subquery result as a table to do more filtering                 |



-- GROUP BY and HAVING in MySQL
-- The GROUP BY clause is used to group rows that have the same values in specified columns and then 
-- apply aggregate functions like COUNT, SUM, AVG, MIN, or MAX on each group.
-- The HAVING clause is used to filter groups after aggregation — similar to how WHERE filters
-- individual rows.
-- We can't use WHERE after applying GROUPBY Instead we have to use HAVING clause.

-- GROUP BY Example: Average Salary by Gender
SELECT gender,AVG(salary) FROM users GROUP BY gender;
-- Explanation:
-- This groups users by gender.
-- Then calculates the average salary for each group.

-- GROUP BY with COUNT
-- Find how many users were referred by each user:
SELECT * FROM users;
SELECT referred_by_id,COUNT(*) AS total_referred FROM users WHERE referred_by_id IS NOT NULL
GROUP BY referred_by_id;

-- HAVING Clause: Filtering Groups
-- Let’s say we only want to show genders where the average salary is greater than ₹75,000.
SELECT gender,AVG(salary) FROM users GROUP BY gender HAVING AVG(salary)>50000;
SELECT gender,AVG(salary) FROM users GROUP BY gender HAVING AVG(salary)>62000;
-- Why not WHERE?
-- WHERE is used before grouping.
-- HAVING is used after groups are formed — it's the only way to filter aggregated values.

-- Another Example: Groups with More Than 1 Referral
SELECT referred_by_id,COUNT(*) AS total_referred FROM users WHERE referred_by_id is NOT NULL
GROUP BY referred_by_id HAVING count(*)>1;

-- Summary
-- Clause	Purpose	Can use aggregates?
-- WHERE	Filters rows before grouping	No
-- GROUP BY	Groups rows based on column values	N/A
-- HAVING	Filters groups after aggregation	Yes
-- Use GROUP BY to organize data, and HAVING to filter those groups based on aggregate conditions.


-- ROLLUP
-- To get subtotals and grand totals, you can use ROLLUP:
SELECT gender, COUNT(*) AS total_users FROM users GROUP BY gender WITH ROLLUP;
-- Explanation:
-- This will give you a count of users by gender, along with a grand total for all users.

